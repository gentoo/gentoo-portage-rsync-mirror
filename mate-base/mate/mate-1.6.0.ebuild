# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/mate/mate-1.6.0.ebuild,v 1.2 2014/05/04 14:53:30 ago Exp $

EAPI="5"

inherit multilib

SRC_URI=""
DESCRIPTION="Meta ebuild for MATE, a traditional desktop environment"
HOMEPAGE="http://mate-desktop.org"

LICENSE="metapackage"

SLOT="0"
KEYWORDS="amd64"
IUSE="bluetooth +extras"

S="${WORKDIR}"

RDEPEND="
	>=mate-base/mate-applets-1.6:0
	>=mate-base/mate-control-center-1.6:0
	>=mate-base/mate-desktop-1.6:0
	>=mate-base/mate-file-manager-1.6:0
	>=mate-base/mate-menus-1.6:0
	>=mate-base/mate-panel-1.6:0
	>=mate-base/mate-session-manager-1.6:0
	>=mate-base/mate-settings-daemon-1.6:0
	>=mate-extra/mate-media-1.6:0
	>=x11-misc/mate-menu-editor-1.6:0
	>=x11-terms/mate-terminal-1.6:0
	>=x11-themes/mate-backgrounds-1.6:0
	>=x11-themes/mate-icon-theme-1.6:0
	>=x11-themes/mate-themes-1.6:0
	>=x11-wm/mate-window-manager-1.6:0
	virtual/notification-daemon:0
	bluetooth? ( >=net-wireless/mate-bluetooth-1.6:0 )
	extras? (
		>=app-arch/mate-file-archiver-1.6:0
		>=app-editors/mate-text-editor-1.6:0
		>=app-text/mate-document-viewer-1.6:0
		>=mate-extra/mate-calc-1.6:0
		>=mate-extra/mate-character-map-1.6:0
		>=mate-extra/mate-power-manager-1.6:0
		>=mate-extra/mate-screensaver-1.6:0
		>=mate-extra/mate-system-monitor-1.6:0
		>=mate-extra/mate-utils-1.6:0
		>=media-gfx/mate-image-viewer-1.6:0
	)"

pkg_postinst() {
	elog "For installation, usage and troubleshooting details;"
	elog "read about MATE on the Gentoo Wiki: https://wiki.gentoo.org/wiki/MATE"
	elog ""
	elog "The MATE desktop environment has been moved to the Portage tree;"
	elog "if you have found a bug, please report it at https://bugs.gentoo.org"
	elog "and provide sufficient details (reproducement, info, logs, errors)."
	elog ""
	elog "MATE 1.6 moved from mateconf to gsettings. This means that the"
	elog "desktop settings and panel applets will return to their default."
	elog "You will have to reconfigure your desktop appearance."
	elog ""
	elog "There is mate-conf-import that converts from mateconf to gsettings."
	elog ""
	elog "For support with mate-conf-import see the following MATE forum topic:"
	elog "http://forums.mate-desktop.org/viewtopic.php?f=16&t=1650"
}
