# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pal/pal-0.4.3-r1.ebuild,v 1.4 2012/11/20 20:45:40 ago Exp $

EAPI=4
inherit toolchain-funcs eutils prefix

DESCRIPTION="pal command-line calendar program"
HOMEPAGE="http://palcal.sourceforge.net/"
SRC_URI="mirror://sourceforge/palcal/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~x86-macos"
IUSE="nls unicode"

RDEPEND=">=dev-libs/glib-2.0
	sys-libs/readline
	sys-libs/ncurses[unicode?]
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${PV}-strip.patch
	epatch "${FILESDIR}"/${PV}-ldflags.patch
	if use unicode; then
		sed -i "/^LIBS/s/-lncurses/&w/" "${S}"/Makefile || die
	fi

	epatch "${FILESDIR}"/${P}-prefix.patch
	eprefixify Makefile.defs input.c Makefile
	sed -i -e 's/ -o root//g' {.,convert}/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" OPT="${CFLAGS}" LDOPT="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install-man install-bin install-share

	if use nls; then
		emake DESTDIR="${D}" install-mo
	fi

	dodoc "${WORKDIR}"/${P}/{ChangeLog,doc/example.css}
}
