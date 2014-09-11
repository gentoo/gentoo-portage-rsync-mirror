# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qttest/qttest-5.3.1-r3.ebuild,v 1.1 2014/09/11 01:46:55 pesa Exp $

EAPI=5

QT5_MODULE="qtbase"
VIRTUALX_REQUIRED="test"

inherit qt5-build

DESCRIPTION="Unit testing library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE=""

RDEPEND="
	~dev-qt/qtcore-${PV}[debug=]
"
DEPEND="${RDEPEND}
	test? (
		~dev-qt/qtgui-${PV}[debug=]
		~dev-qt/qtxml-${PV}[debug=]
	)
"

QT5_TARGET_SUBDIRS=(
	src/testlib
)
