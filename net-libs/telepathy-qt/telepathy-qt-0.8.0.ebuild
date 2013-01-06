# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-qt/telepathy-qt-0.8.0.ebuild,v 1.8 2012/07/31 08:38:50 scarabeus Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
MY_PN=${PN}4
inherit python base cmake-utils

DESCRIPTION="Qt4 bindings for the Telepathy D-Bus protocol"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug farsight glib test"

RESTRICT="test" #423089

RDEPEND="
	dev-python/dbus-python
	x11-libs/qt-core:4[glib?]
	x11-libs/qt-dbus:4
	farsight? (
		dev-libs/dbus-glib
		dev-libs/libxml2
		media-libs/gstreamer
		>=net-libs/telepathy-glib-0.15.1
		net-libs/telepathy-farsight
	)
	glib? ( dev-libs/glib:2 )
	!net-libs/telepathy-qt4
"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	virtual/pkgconfig
	test? ( x11-libs/qt-test:4 )
"

PATCHES=( "${FILESDIR}/${P}-automagicness.patch" )

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	base_src_prepare

	sed -i -e '/^add_subdirectory(examples)$/d' CMakeLists.txt || die

	if ! use test ; then
		sed -i -e '/^add_subdirectory(tests)$/d' CMakeLists.txt || die
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable debug DEBUG_OUTPUT)
		$(cmake-utils_use_with glib)
		$(cmake-utils_use_with farsight)
	)
	cmake-utils_src_configure
}
