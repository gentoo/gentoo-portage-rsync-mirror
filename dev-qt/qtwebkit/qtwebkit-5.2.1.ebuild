# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtwebkit/qtwebkit-5.2.1.ebuild,v 1.1 2014/04/23 07:18:25 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-any-r1 qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

# TODO: qtprintsupport, qttestlib, geolocation, orientation/sensors

IUSE="gstreamer libxml2 multimedia opengl qml udev webp widgets xslt"

RDEPEND="
	dev-db/sqlite:3
	>=dev-qt/qtcore-${PV}:5[debug=,icu]
	>=dev-qt/qtgui-${PV}:5[debug=]
	>=dev-qt/qtnetwork-${PV}:5[debug=]
	>=dev-qt/qtsql-${PV}:5[debug=]
	media-libs/fontconfig:1.0
	media-libs/libpng:0=
	sys-libs/zlib
	virtual/jpeg:0
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXrender
	gstreamer? (
		dev-libs/glib:2
		>=media-libs/gstreamer-0.10.30:0.10
		>=media-libs/gst-plugins-base-0.10.30:0.10
	)
	libxml2? ( dev-libs/libxml2:2 )
	multimedia? ( >=dev-qt/qtmultimedia-${PV}:5[debug=] )
	opengl? ( >=dev-qt/qtopengl-${PV}:5[debug=] )
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )
	udev? ( virtual/udev )
	webp? ( media-libs/libwebp:0= )
	widgets? ( >=dev-qt/qtwidgets-${PV}:5[debug=] )
	xslt? (
		libxml2? ( dev-libs/libxslt )
		!libxml2? ( >=dev-qt/qtxmlpatterns-${PV}:5[debug=] )
	)
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-lang/ruby
	sys-devel/bison
	sys-devel/flex
"

pkg_setup() {
	python-any-r1_pkg_setup
	qt5-build_pkg_setup
}

src_prepare() {
	use gstreamer  || epatch "${FILESDIR}/${PN}-5.2.1-disable-gstreamer.patch"
	use libxml2    || sed -i -e '/config_libxml2: WEBKIT_CONFIG += use_libxml2/d' \
		Tools/qmake/mkspecs/features/features.prf || die
	use multimedia || sed -i -e '/WEBKIT_CONFIG += video use_qt_multimedia/d' \
		Tools/qmake/mkspecs/features/features.prf || die
	use opengl     || sed -i -e '/contains(QT_CONFIG, opengl): WEBKIT_CONFIG += use_3d_graphics/d' \
		Tools/qmake/mkspecs/features/features.prf || die
	use qml        || sed -i -e '/have?(QTQUICK): SUBDIRS += declarative/d' \
		Source/QtWebKit.pro || die
	use udev       || sed -i -e '/linux: WEBKIT_CONFIG += gamepad/d' \
		Tools/qmake/mkspecs/features/features.prf || die
	use webp       || sed -i -e '/config_libwebp: WEBKIT_CONFIG += use_webp/d' \
		Tools/qmake/mkspecs/features/features.prf || die
	use widgets    || sed -i -e '/SUBDIRS += webkitwidgets/d' \
		Source/QtWebKit.pro || die
	use xslt       || sed -i -e '/config_libxslt: WEBKIT_CONFIG += xslt/d' \
		Tools/qmake/mkspecs/features/features.prf || die

	# bug 458222
	sed -i -e '/SUBDIRS += examples/d' Source/QtWebKit.pro || die

	qt5-build_src_prepare
}
