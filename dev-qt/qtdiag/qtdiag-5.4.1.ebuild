# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtdiag/qtdiag-5.4.1.ebuild,v 1.1 2015/02/24 18:49:08 pesa Exp $

EAPI=5

QT5_MODULE="qttools"

inherit qt5-build

DESCRIPTION="Tool for reporting diagnostic information about Qt and its environment"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE="+opengl +ssl"

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=,opengl=]
	>=dev-qt/qtnetwork-${PV}:5[debug=,ssl=]
"
RDEPEND="${DEPEND}"

QT5_TARGET_SUBDIRS=(
	src/qtdiag
)
