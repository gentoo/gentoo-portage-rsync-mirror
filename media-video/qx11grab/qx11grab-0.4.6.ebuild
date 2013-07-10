# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qx11grab/qx11grab-0.4.6.ebuild,v 1.6 2013/07/10 04:54:34 patrick Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="X11 desktop video grabber tray"
HOMEPAGE="http://qx11grab.hjcms.de/"
SRC_URI="http://qx11grab.hjcms.de/downloads/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kde opengl pulseaudio"

RDEPEND="
	>=media-libs/alsa-lib-1.0.24
	>=media-libs/fontconfig-2.4
	>=media-libs/freetype-2.4:2
	>=sys-apps/dbus-1.4.16
	>=x11-libs/libX11-1.3.4
	>=x11-libs/libXrandr-1.3
	>=dev-qt/qtcore-4.7.2:4
	>=dev-qt/qtdbus-4.7.2:4
	>=dev-qt/qtgui-4.7.2:4[dbus(+)]
	>=virtual/ffmpeg-0.10.3[X,encode,truetype]
	kde? ( kde-base/kdelibs:4 )
	opengl? ( >=dev-qt/qtopengl-4.7.2:4 )
	pulseaudio? ( media-sound/pulseaudio )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	kde? ( dev-util/automoc )
"
PDEPEND="virtual/freedesktop-icon-theme"

src_prepare() {
	cmake-utils_src_prepare

	# install docs into standard Gentoo location
	sed -i -e "/DESTINATION share/ s:\${CMAKE_PROJECT_NAME}:doc/${PF}:" \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable kde KDE_SUPPORT)
		$(cmake-utils_use_enable opengl)
		$(cmake-utils_use_enable pulseaudio PULSE)
	)
	cmake-utils_src_configure
}
