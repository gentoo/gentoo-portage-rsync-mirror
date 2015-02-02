# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtwebsockets/qtwebsockets-5.4.0.ebuild,v 1.2 2015/02/02 19:27:58 zlogene Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Implementation of the WebSocket protocol for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~x86"
fi

IUSE="qml"

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtnetwork-${PV}:5[debug=]
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )

"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod qml quick src/src.pro

	qt5-build_src_prepare
}
