# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-extra-apps/gnome-extra-apps-3.4.1.ebuild,v 1.2 2012/11/05 21:35:29 ulm Exp $

EAPI="4"

DESCRIPTION="Sub-meta package for the applications of GNOME 3"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="+shotwell +tracker"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~amd64 ~x86"

# Note to developers:
# This is a wrapper for the extra apps integrated with GNOME 3
# New package
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}

	>=app-admin/gnome-system-log-${PV}
	>=app-arch/file-roller-${PV}
	>=app-dicts/gnome-dictionary-3.4
	>=games-board/aisleriot-3.2.3.2
	>=gnome-extra/gcalctool-6.4.1
	>=gnome-extra/gconf-editor-3.0.0
	>=gnome-extra/gnome-games-${PV}
	>=gnome-extra/gnome-search-tool-3.4
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-3.4
	>=gnome-extra/gucharmap-${PV}:2.90
	>=gnome-extra/sushi-0.4.1
	>=mail-client/evolution-${PV}
	>=media-gfx/gnome-font-viewer-3.4
	>=media-gfx/gnome-screenshot-${PV}
	>=media-sound/sound-juicer-3.4
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.2
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-${PV}
	>=sys-apps/baobab-${PV}
	>=www-client/epiphany-${PV}

	shotwell? ( >=media-gfx/shotwell-0.12 )
	tracker? (
		>=app-misc/tracker-0.14.1
		>=gnome-extra/gnome-documents-0.4.1 )
"
# Note: bug-buddy is broken with GNOME 3
# Note: aisleriot-3.4 is masked for guile-2
DEPEND=""
S=${WORKDIR}
