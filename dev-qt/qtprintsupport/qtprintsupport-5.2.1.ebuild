# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtprintsupport/qtprintsupport-5.2.1.ebuild,v 1.1 2014/04/23 07:10:53 patrick Exp $

EAPI=5

QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE="cups"

RDEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=]
	~dev-qt/qtwidgets-${PV}[debug=]
	cups? ( net-print/cups )
"
DEPEND="${RDEPEND}
	test? ( ~dev-qt/qtnetwork-${PV}[debug=] )
"

QT5_TARGET_SUBDIRS=(
	src/printsupport
	src/plugins/printsupport
)

pkg_setup() {
	QCONFIG_ADD=(
		$(usev cups)
	)
	qt5-build_pkg_setup
}

src_configure() {
	local myconf=(
		$(qt_use cups)
	)
	qt5-build_src_configure
}
