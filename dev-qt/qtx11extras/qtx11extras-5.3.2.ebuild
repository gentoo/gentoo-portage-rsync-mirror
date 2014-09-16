# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtx11extras/qtx11extras-5.3.2.ebuild,v 1.1 2014/09/16 14:47:55 pesa Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Linux/X11-specific support library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

IUSE=""

RDEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	~dev-qt/qtgui-${PV}[debug=,xcb]
	~dev-qt/qtwidgets-${PV}[debug=]
"
DEPEND="${RDEPEND}"
