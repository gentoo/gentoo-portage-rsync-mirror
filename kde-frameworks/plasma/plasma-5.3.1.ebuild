# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/plasma/plasma-5.3.1.ebuild,v 1.1 2014/10/23 13:54:35 mrueg Exp $

EAPI=5

KMNAME="${PN}-framework"
VIRTUALX_REQUIRED="test"
inherit kde5

SRC_URI="mirror://kde/stable/frameworks/${PV/1/0}/${KMNAME}-${PV}.tar.xz"

DESCRIPTION="Plasma framework"
LICENSE="LGPL-2+"
KEYWORDS=" ~amd64"
IUSE="egl opengl X"

RDEPEND="
	$(add_frameworks_dep kactivities '' 5.3.0)
	$(add_frameworks_dep karchive '' 5.3.0)
	$(add_frameworks_dep kconfig '' 5.3.0)
	$(add_frameworks_dep kconfigwidgets '' 5.3.0)
	$(add_frameworks_dep kcoreaddons '' 5.3.0)
	$(add_frameworks_dep kdbusaddons '' 5.3.0)
	$(add_frameworks_dep kdeclarative '' 5.3.0)
	$(add_frameworks_dep kglobalaccel '' 5.3.0)
	$(add_frameworks_dep kguiaddons '' 5.3.0)
	$(add_frameworks_dep ki18n '' 5.3.0)
	$(add_frameworks_dep kiconthemes '' 5.3.0)
	$(add_frameworks_dep kio '' 5.3.0)
	$(add_frameworks_dep kservice '' 5.3.0)
	$(add_frameworks_dep kwindowsystem '' 5.3.0)
	$(add_frameworks_dep kxmlgui '' 5.3.0)
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtscript:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	X? (
		dev-qt/qtx11extras:5
		x11-libs/libX11
		x11-libs/libxcb
	)
"
DEPEND="${RDEPEND}
	$(add_frameworks_dep kdoctools '' 5.3.0)
	dev-qt/qtquick1:5
	egl? ( media-libs/mesa[egl] )
	opengl? (
		dev-qt/qtgui:5[opengl,-gles2]
		virtual/opengl
	)
	X? ( x11-proto/xproto )
"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package egl EGL)
		$(cmake-utils_use_find_package opengl OpenGL)
		$(cmake-utils_use_find_package X X11)
		$(cmake-utils_use_find_package X XCB)
	)

	kde5_src_configure
}
