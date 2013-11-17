# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclreadline/tclreadline-2.1.0-r3.ebuild,v 1.1 2013/11/17 09:31:58 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils multilib toolchain-funcs

DESCRIPTION="Readline extension to TCL"
HOMEPAGE="http://tclreadline.sf.net/"
SRC_URI="mirror://sourceforge/tclreadline/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

DEPEND="
	dev-lang/tcl
	sys-libs/readline"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-gold.patch )

src_prepare() {
	sed \
		-e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" \
		-i configure.in || die
	mv configure.{in,ac} || die
	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--with-tcl="${EPREFIX}/usr/$(get_libdir)"
		--with-tcl-includes="${EPREFIX}/usr/include"
		--with-readline-includes="${EPREFIX}/usr/include"
		--with-readline-library="${EPREFIX}/usr/$(get_libdir)"
		--with-tlib-library="$($(tc-getPKG_CONFIG) --libs ncurses)"
		)
	autotools-utils_src_configure
}
