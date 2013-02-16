# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-full/leechcraft-full-0.5.90-r1.ebuild,v 1.3 2013/02/16 21:30:02 ago Exp $

EAPI="4"

DESCRIPTION="Metapackage containing all ready-to-use LeechCraft plugins"
HOMEPAGE="http://leechcraft.org/"

SLOT="0"
KEYWORDS="amd64 x86"
LICENSE="GPL-3"
IUSE="kde unstable"

RDEPEND="
		~app-editors/leechcraft-popishu-${PV}
		~app-text/leechcraft-monocle-${PV}
		~media-sound/leechcraft-hotstreams-${PV}
		~media-sound/leechcraft-lmp-${PV}
		~media-sound/leechcraft-lastfmscrobble-${PV}
		~media-sound/leechcraft-musiczombie-${PV}
		~net-analyzer/leechcraft-networkmonitor-${PV}
		~net-im/leechcraft-azoth-${PV}
		~net-misc/leechcraft-advancednotifications-${PV}
		kde? ( ~net-misc/leechcraft-anhero-${PV} )
		~net-misc/leechcraft-auscrie-${PV}
		~net-misc/leechcraft-core-${PV}
		~net-misc/leechcraft-cstp-${PV}
		~net-misc/leechcraft-dbusmanager-${PV}
		~net-misc/leechcraft-gacts-${PV}
		~net-misc/leechcraft-glance-${PV}
		~net-misc/leechcraft-historyholder-${PV}
		~net-misc/leechcraft-kinotify-${PV}
		~net-misc/leechcraft-knowhow-${PV}
		~net-misc/leechcraft-lackman-${PV}
		~net-misc/leechcraft-launchy-${PV}
		~net-misc/leechcraft-lemon-${PV}
		~net-misc/leechcraft-liznoo-${PV}
		~net-misc/leechcraft-newlife-${PV}
		~net-misc/leechcraft-netstoremanager-${PV}
		~net-misc/leechcraft-otlozhu-${PV}
		~net-misc/leechcraft-qrosp-${PV}
		~net-misc/leechcraft-pintab-${PV}
		~net-misc/leechcraft-secman-${PV}
		~net-misc/leechcraft-summary-${PV}
		~net-misc/leechcraft-tabpp-${PV}
		~net-misc/leechcraft-tabslist-${PV}
		~net-misc/leechcraft-tabsessmanager-${PV}
		~net-news/leechcraft-aggregator-${PV}
		~net-p2p/leechcraft-bittorrent-${PV}
		~net-proxy/leechcraft-xproxy-${PV}
		~sys-fs/leechcraft-vrooby-${PV}
		~virtual/leechcraft-trayarea-${PV}
		~www-client/leechcraft-deadlyrics-${PV}
		~www-client/leechcraft-dolozhee-${PV}
		~www-client/leechcraft-poshuku-${PV}
		~www-client/leechcraft-vgrabber-${PV}
		~www-misc/leechcraft-pogooglue-${PV}
		~www-misc/leechcraft-seekthru-${PV}
		~x11-plugins/leechcraft-tpi-${PV}
		unstable? ( ~media-sound/leechcraft-touchstreams-${PV} )
		"
DEPEND=""
