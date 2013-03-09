# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/leechcraft-meta/leechcraft-meta-0.5.85.ebuild,v 1.1 2013/03/09 19:33:00 maksbotan Exp $

EAPI="4"

DESCRIPTION="Metapackage containing all ready-to-use LeechCraft plugins"
HOMEPAGE="http://leechcraft.org/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
IUSE="kde"

RDEPEND="
		~app-leechcraft/lc-popishu-${PV}
		~app-leechcraft/lc-monocle-${PV}
		~app-leechcraft/lc-hotstreams-${PV}
		~app-leechcraft/lc-lmp-${PV}
		~app-leechcraft/lc-lastfmscrobble-${PV}
		~app-leechcraft/lc-networkmonitor-${PV}
		~app-leechcraft/lc-azoth-${PV}
		~app-leechcraft/lc-advancednotifications-${PV}
		kde? ( ~app-leechcraft/lc-anhero-${PV} )
		~app-leechcraft/lc-auscrie-${PV}
		~app-leechcraft/lc-core-${PV}
		~app-leechcraft/lc-cstp-${PV}
		~app-leechcraft/lc-dbusmanager-${PV}
		~app-leechcraft/lc-gacts-${PV}
		~app-leechcraft/lc-glance-${PV}
		~app-leechcraft/lc-historyholder-${PV}
		~app-leechcraft/lc-kinotify-${PV}
		~app-leechcraft/lc-knowhow-${PV}
		~app-leechcraft/lc-lackman-${PV}
		~app-leechcraft/lc-launchy-${PV}
		~app-leechcraft/lc-liznoo-${PV}
		~app-leechcraft/lc-newlife-${PV}
		~app-leechcraft/lc-netstoremanager-${PV}
		~app-leechcraft/lc-otlozhu-${PV}
		~app-leechcraft/lc-qrosp-${PV}
		~app-leechcraft/lc-pintab-${PV}
		~app-leechcraft/lc-secman-${PV}
		~app-leechcraft/lc-sidebar-${PV}
		~app-leechcraft/lc-summary-${PV}
		~app-leechcraft/lc-tabpp-${PV}
		~app-leechcraft/lc-tabslist-${PV}
		~app-leechcraft/lc-tabsessmanager-${PV}
		~app-leechcraft/lc-aggregator-${PV}
		~app-leechcraft/lc-bittorrent-${PV}
		~app-leechcraft/lc-xproxy-${PV}
		~app-leechcraft/lc-vrooby-${PV}
		~app-leechcraft/lc-deadlyrics-${PV}
		~app-leechcraft/lc-dolozhee-${PV}
		~app-leechcraft/lc-poshuku-${PV}
		~app-leechcraft/lc-vgrabber-${PV}
		~app-leechcraft/lc-seekthru-${PV}
		"
DEPEND=""
