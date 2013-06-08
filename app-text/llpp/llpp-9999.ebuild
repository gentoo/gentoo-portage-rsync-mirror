# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/llpp/llpp-9999.ebuild,v 1.19 2013/06/08 14:23:15 xmw Exp $

EAPI=5

inherit eutils git-2 toolchain-funcs

DESCRIPTION="a graphical PDF viewer which aims to superficially resemble less(1)"
HOMEPAGE="http://repo.or.cz/w/llpp.git"
EGIT_REPO_URI="git://repo.or.cz/llpp.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+ocamlopt static"

LIB_DEPEND=">=app-text/mupdf-9999:=[static-libs]
	media-libs/openjpeg:0[static-libs]
	media-libs/freetype:2[static-libs]
	media-libs/jbig2dec[static-libs]
	sys-libs/zlib[static-libs]
	virtual/jpeg:0[static-libs]
	x11-libs/libX11[static-libs]"
RDEPEND="x11-misc/xsel
	!static? ( ${LIB_DEPEND//\[static-libs]} )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	dev-lang/ocaml[ocamlopt?]
	dev-ml/lablgl[glut,ocamlopt?]"

RESTRICT="!ocamlopt? ( strip )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-11-WM_CLASS.patch \
		"${FILESDIR}"/${P}-mupdf_trailer.patch
}

src_compile() {
	local ocaml=$(usex ocamlopt ocamlopt.opt ocamlc.opt)
	local cmo=$(usex ocamlopt cmx cmo)
	local cma=$(usex ocamlopt cmxa cma)
	local ccopt="$(freetype-config --cflags ) -O -include ft2build.h -D_GNU_SOURCE"
	if use static ; then
		local cclib="-Wl,-Bstatic $($(tc-getPKG_CONFIG) --libs --static mupdf x11 | sed 's: -l\(m\|pthread\) : :g') -Wl,-Bdynamic -lm -lpthread"
	else
		local cclib="$($(tc-getPKG_CONFIG) --libs mupdf x11 freetype2 libopenjpeg1) -ljbig2dec -ljpeg"
	fi

	verbose() { echo "$@" >&2 ; "$@" || die ; }
	verbose ocaml str.cma keystoml.ml KEYS > help.ml
	verbose printf 'let version ="%s";;\n' ${PV} >> help.ml
	verbose ${ocaml} -c -o link.o -ccopt "${ccopt}" link.c
	verbose ${ocaml} -c -o help.${cmo} help.ml
	verbose ${ocaml} -c -o utils.${cmo} utils.ml
	verbose ${ocaml} -c -o wsi.cmi wsi.mli
	verbose ${ocaml} -c -o wsi.${cmo} wsi.ml
	verbose ${ocaml} -c -o parser.${cmo} parser.ml
	verbose ${ocaml} -c -o main.${cmo} -I +lablGL main.ml
	verbose ${ocaml} $(usex ocamlopt "" -custom) -o llpp -I +lablGL\
		str.${cma} unix.${cma} lablgl.${cma} link.o \
	    -cclib "${cclib}" \
		help.${cmo} utils.${cmo} parser.${cmo} wsi.${cmo} main.${cmo}
}

src_install() {
	dobin ${PN}
	dodoc KEYS README Thanks fixme
}
