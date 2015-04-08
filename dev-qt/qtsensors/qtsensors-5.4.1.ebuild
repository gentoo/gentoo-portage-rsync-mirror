# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtsensors/qtsensors-5.4.1.ebuild,v 1.2 2015/03/08 14:02:39 pesa Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Hardware sensor access library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE="qml"

RDEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )
"
DEPEND="${RDEPEND}"

src_prepare() {
	qt_use_disable_mod qml quick \
		src/src.pro

	qt5-build_src_prepare
}
