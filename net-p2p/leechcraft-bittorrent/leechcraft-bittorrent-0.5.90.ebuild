# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/leechcraft-bittorrent/leechcraft-bittorrent-0.5.90.ebuild,v 1.3 2013/02/16 21:32:21 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Full-featured BitTorrent client plugin for LeechCraft."

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug geoip"

DEPEND="~net-misc/leechcraft-core-${PV}
		net-libs/rb_libtorrent"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show
		geoip? ( dev-libs/geoip )"

src_configure(){
	local mycmakeargs="
		$(cmake-utils_use_enable geoip BITTORRENT_GEOIP)
	"
	cmake-utils_src_configure
}
