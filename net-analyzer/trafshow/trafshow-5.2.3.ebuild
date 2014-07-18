# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafshow/trafshow-5.2.3.ebuild,v 1.14 2014/07/18 03:11:48 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Full screen visualization of the network traffic"
HOMEPAGE="http://soft.risp.ru/trafshow/index_en.shtml"
SRC_URI="ftp://ftp.nsk.su/pub/RinetSoftware/${P}.tgz"

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 hppa ~ppc ppc64 sparc x86"
IUSE="slang"

DEPEND="
	net-libs/libpcap
	slang? ( >=sys-libs/slang-1.4 )
	sys-libs/ncurses
"

src_prepare() {
	cat /usr/share/aclocal/pkg.m4 >> aclocal.m4 || die
	epatch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-tinfo.patch
	eautoreconf
}

src_configure() {
	if ! use slang; then
		# No command-line option so pre-cache instead
		export ac_cv_have_curses=ncurses
		export LIBS=-lncurses
	fi

	econf
}
