# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/pshs/pshs-9999.ebuild,v 1.1 2012/12/15 12:44:58 mgorny Exp $

EAPI=4

#if LIVE
AUTOTOOLS_AUTORECONF=yes
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"

inherit git-2
#endif

inherit autotools-utils

DESCRIPTION="Pretty small HTTP server - a command-line tool to share files"
HOMEPAGE="https://bitbucket.org/mgorny/pshs/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+magic +netlink upnp"

RDEPEND=">=dev-libs/libevent-2
	magic? ( sys-apps/file )
	upnp? ( net-libs/miniupnpc )"
DEPEND="${RDEPEND}
	netlink? ( sys-apps/iproute2
		>=sys-kernel/linux-headers-2.6.27 )"
# libnetlink is static only ATM

#if LIVE
KEYWORDS=
SRC_URI=
#endif

src_configure() {
	myeconfargs=(
		$(use_enable magic libmagic)
		$(use_enable netlink)
		$(use_enable upnp)
	)

	autotools-utils_src_configure
}
