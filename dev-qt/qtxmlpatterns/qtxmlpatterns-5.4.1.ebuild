# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtxmlpatterns/qtxmlpatterns-5.4.1.ebuild,v 1.2 2015/03/08 14:04:09 pesa Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="XPath, XQuery, and XSLT support library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtnetwork-${PV}:5[debug=]
"
RDEPEND="${DEPEND}"
