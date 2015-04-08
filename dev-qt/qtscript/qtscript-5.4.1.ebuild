# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtscript/qtscript-5.4.1.ebuild,v 1.3 2015/03/08 14:02:34 pesa Exp $

EAPI=5

inherit qt5-build

DESCRIPTION="Application scripting library for the Qt5 framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~x86"
fi

IUSE="scripttools"

DEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	scripttools? (
		>=dev-qt/qtgui-${PV}:5[debug=]
		>=dev-qt/qtwidgets-${PV}:5[debug=]
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod scripttools widgets \
		src/src.pro

	qt5-build_src_prepare
}
