# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxqt-base/lxqt-panel/lxqt-panel-0.7.0-r1.ebuild,v 1.3 2014/05/29 18:01:43 jauhien Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="LXQt desktop panel and plugins"
HOMEPAGE="http://www.lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.lxde.org/git/lxde/${PN}.git"
else
	SRC_URI="http://lxqt.org/downloads/lxqt/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~x86"
	S=${WORKDIR}
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
IUSE="+alsa +clock colorpicker cpuload +desktopswitch dom +kbindicator +mainmenu
	+mount networkmonitor pulseaudio +quicklaunch screensaver sensors
	+showdesktop sysstat +taskbar teatime +tray +volume worldclock"
REQUIRED_USE="volume? ( || ( alsa pulseaudio ) )"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	>=lxde-base/menu-cache-0.3.3
	lxqt-base/liblxqt
	lxqt-base/liblxqt-mount
	lxqt-base/libsysstat
	lxqt-base/lxqt-globalkeys
	razorqt-base/libqtxdg
	x11-libs/libX11
	cpuload? ( sys-libs/libstatgrab )
	networkmonitor? ( sys-libs/libstatgrab )
	sensors? ( sys-apps/lm_sensors )
	sysstat? ( lxqt-base/libsysstat )
	volume? ( alsa? ( media-libs/alsa-lib )
		pulseaudio? ( media-sound/pulseaudio ) )
	worldclock? ( dev-libs/icu:= )"
RDEPEND="${DEPEND}
	lxde-base/lxmenu-data"

src_configure() {
	local mycmakeargs i y
	for i in clock colorpicker cpuload desktopswitch dom kbindicator mainmenu mount \
		networkmonitor quicklaunch screensaver sensors showdesktop sysstat \
		taskbar teatime tray volume worldclock; do
		y=$(tr '[:lower:]' '[:upper:]' <<< "${i}")
		mycmakeargs+=( $(cmake-utils_use ${i} ${y}_PLUGIN) )
	done

	if use volume; then
		mycmakeargs+=( $(cmake-utils_use alsa VOLUME_USE_ALSA)
			$(cmake-utils_use pulseaudio VOLUME_USE_PULSEAUDIO) )
	fi

	cmake-utils_src_configure
}

src_install(){
	cmake-utils_src_install
	doman panel/man/*.1
}
