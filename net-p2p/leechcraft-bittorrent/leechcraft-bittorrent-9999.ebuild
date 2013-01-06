# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/leechcraft-bittorrent/leechcraft-bittorrent-9999.ebuild,v 1.3 2012/08/04 09:06:13 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Full-featured BitTorrent client plugin for LeechCraft."

SLOT="0"
KEYWORDS=""
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
