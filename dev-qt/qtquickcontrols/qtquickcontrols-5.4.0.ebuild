# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtquickcontrols/qtquickcontrols-5.4.0.ebuild,v 1.2 2015/02/02 19:21:15 zlogene Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Set of controls used in conjunction with Qt Quick to build complete interfaces"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
fi

IUSE="widgets"

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtdeclarative-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=]
	widgets? ( >=dev-qt/qtwidgets-${PV}:5[debug=] )
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod widgets widgets \
		src/src.pro \
		src/controls/Private/private.pri \
		tests/auto/activeFocusOnTab/activeFocusOnTab.pro \
		tests/auto/controls/controls.pro \
		tests/auto/testplugin/testplugin.pro

	qt5-build_src_prepare
}
