# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qttranslations/qttranslations-5.4.0.ebuild,v 1.3 2015/02/03 12:04:15 jer Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Translation files for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/linguist-tools-${PV}:5
	>=dev-qt/qtcore-${PV}:5[debug=]
"
RDEPEND="${DEPEND}"
