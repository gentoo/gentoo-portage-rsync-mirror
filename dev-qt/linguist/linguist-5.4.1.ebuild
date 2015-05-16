# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/linguist/linguist-5.4.1.ebuild,v 1.2 2015/05/16 10:44:46 jer Exp $

EAPI=5

QT5_MODULE="qttools"

inherit qt5-build

DESCRIPTION="Graphical tool for translating Qt applications"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa ~ppc64"
else
	KEYWORDS="~amd64 ~arm ~hppa ~ppc64 ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/designer-${PV}:5[debug=]
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=]
	>=dev-qt/qtprintsupport-${PV}:5[debug=]
	>=dev-qt/qtwidgets-${PV}:5[debug=]
	>=dev-qt/qtxml-${PV}:5[debug=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/linguist/linguist
)
