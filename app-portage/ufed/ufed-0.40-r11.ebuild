# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40-r11.ebuild,v 1.4 2013/02/02 12:15:02 alexxy Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_prepare() {
	epatch "${FILESDIR}"/${P}-useorder.patch
	epatch "${FILESDIR}"/${P}-source.patch
	epatch "${FILESDIR}"/${P}-comments.patch
	epatch "${FILESDIR}"/${P}-masked.patch
	epatch "${FILESDIR}"/${P}-packageusemask.patch
	epatch "${FILESDIR}"/${P}-noremove.patch
	epatch "${FILESDIR}"/${P}-termsize.patch
	epatch "${FILESDIR}"/${P}-multiple-inheritance.patch
	epatch "${FILESDIR}"/${P}-termsize-2.patch
}

src_configure() {
	tc-export CC
	./configure || die
}

src_install() {
	newsbin ufed.pl ufed || die
	doman ufed.8
	insinto /usr/lib/ufed
	doins *.pm || die
	exeinto /usr/lib/ufed
	doexe ufed-curses || die
}
