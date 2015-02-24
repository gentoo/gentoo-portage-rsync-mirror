# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtserialport/qtserialport-5.4.1.ebuild,v 1.1 2015/02/24 18:45:55 pesa Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Serial port abstraction library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS="~hppa"
else
	KEYWORDS="~amd64 ~arm ~hppa ~x86"
fi

IUSE=""

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	virtual/udev
"
RDEPEND="${DEPEND}"
