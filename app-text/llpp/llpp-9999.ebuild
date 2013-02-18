# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/llpp/llpp-9999.ebuild,v 1.16 2013/02/17 23:13:52 xmw Exp $

EAPI=4

EGIT_REPO_URI="git://repo.or.cz/llpp.git"

inherit eutils git-2 toolchain-funcs

DESCRIPTION="a graphical PDF viewer which aims to superficially resemble less(1)"
HOMEPAGE="http://repo.or.cz/w/llpp.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="media-libs/freetype
	media-libs/jbig2dec
	media-libs/openjpeg
	virtual/jpeg
	x11-libs/libX11
	x11-misc/xsel"
DEPEND="${RDEPEND}
	>=app-text/mupdf-1.0
	dev-lang/ocaml[ocamlopt]
	dev-ml/lablgl[glut]"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-11-WM_CLASS.patch
}

src_compile() {
	ocaml str.cma keystoml.ml KEYS > help.ml || die
	printf 'let version ="%s";;\n' $(git describe --tags --dirty) >> help.ml || die

	local myccopt="$(freetype-config --cflags) -O -include ft2build.h -D_GNU_SOURCE"
	local mycclib="-lfitz -lz -ljpeg -lopenjpeg -ljbig2dec -lfreetype -lX11 -lpthread"
	ocamlopt.opt -c -o link.o -ccopt "${myccopt}" link.c || die
	ocamlopt.opt -c -o help.cmx help.ml || die
	ocamlopt.opt -c -o utils.cmx utils.ml || die
	ocamlopt.opt -c -o wsi.cmi wsi.mli || die
	ocamlopt.opt -c -o wsi.cmx wsi.ml || die
	ocamlopt.opt -c -o parser.cmx parser.ml || die
	ocamlopt.opt -c -o main.cmx -I +lablGL main.ml || die
	ocamlopt.opt -o llpp -I +lablGL \
		str.cmxa unix.cmxa lablgl.cmxa link.o \
	    -cclib "${mycclib}" help.cmx utils.cmx parser.cmx wsi.cmx main.cmx \
		|| die
}

src_install() {
	dobin ${PN}
	dodoc KEYS README Thanks fixme
}
