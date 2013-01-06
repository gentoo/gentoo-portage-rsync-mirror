# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/trafshow/trafshow-5.2.3.ebuild,v 1.13 2012/12/05 16:47:32 jer Exp $

inherit eutils

DESCRIPTION="Full screen visualization of the network traffic"
HOMEPAGE="http://soft.risp.ru/trafshow/index_en.shtml"
SRC_URI="ftp://ftp.nsk.su/pub/RinetSoftware/${P}.tgz"

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 hppa ~ppc ppc64 sparc x86"
IUSE="slang"

DEPEND="net-libs/libpcap
	sys-libs/ncurses
	slang? ( >=sys-libs/slang-1.4 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	if ! use slang; then
		# No command-line option so pre-cache instead
		export ac_cv_have_curses=ncurses
		export LIBS=-lncurses
	fi

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
}
