# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/pixeltool/pixeltool-5.4.1.ebuild,v 1.1 2015/02/24 18:46:32 pesa Exp $

EAPI=5

QT5_MODULE="qttools"

inherit qt5-build

DESCRIPTION="Qt screen magnifier"

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
	>=dev-qt/qtwidgets-${PV}:5[debug=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/pixeltool
)
