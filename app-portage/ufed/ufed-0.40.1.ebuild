# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/ufed/ufed-0.40.1.ebuild,v 1.9 2012/06/02 07:01:30 zmedico Exp $

EAPI=2

inherit multilib

DESCRIPTION="Gentoo Linux USE flags editor"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://dev.gentoo.org/~truedfx/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_configure() {
	econf --libexecdir=/usr/$(get_libdir)/ufed
}

src_install() {
	emake DESTDIR="${D}" install || die
}
