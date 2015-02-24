# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qthelp/qthelp-5.4.1.ebuild,v 1.1 2015/02/24 18:35:57 pesa Exp $

EAPI=5

QT5_MODULE="qttools"

inherit qt5-build

DESCRIPTION="The Help module for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=]
	>=dev-qt/qtnetwork-${PV}:5[debug=]
	>=dev-qt/qtsql-${PV}:5[debug=,sqlite]
	>=dev-qt/qtwidgets-${PV}:5[debug=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/assistant/clucene
	src/assistant/help
	src/assistant/qcollectiongenerator
	src/assistant/qhelpconverter
	src/assistant/qhelpgenerator
)
