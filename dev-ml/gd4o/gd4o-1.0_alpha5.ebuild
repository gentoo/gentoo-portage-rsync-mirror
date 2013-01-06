# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/gd4o/gd4o-1.0_alpha5.ebuild,v 1.2 2011/02/25 20:07:40 signals Exp $

EAPI=3

inherit toolchain-funcs findlib

MY_P="${P/_alpha/a}"

DESCRIPTION="OCaml interface to the GD graphics library"
HOMEPAGE="http://sourceforge.net/projects/gd4o/"
SRC_URI="mirror://sourceforge/gd4o/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc +ocamlopt"

DEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]
	media-libs/gd
	virtual/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/freetype:2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i 's/CFLAGS =/CFLAGS += -fPIC/' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
	if use ocamlopt ; then
		emake CC="$(tc-getCC)" opt || die
	fi
	if use doc ; then
		emake docs || die
	fi
}

src_test() {
	emake test || die
	if use ocamlopt ; then
		emake test.opt || die
	fi
}

src_install() {
	findlib_src_install
	dodoc BUGS CHANGES README* TODO doc/manual.txt
	use doc && dohtml -r doc
}
