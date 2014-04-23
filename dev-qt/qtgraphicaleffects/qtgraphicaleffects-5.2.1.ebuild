# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtgraphicaleffects/qtgraphicaleffects-5.2.1.ebuild,v 1.1 2014/04/23 07:06:51 patrick Exp $

EAPI=5

inherit qt5-build virtualx

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE=""

RDEPEND="
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtdeclarative-${PV}:5[debug=]
	>=dev-qt/qtxmlpatterns-${PV}:5[debug=]
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtgui-${PV}:5[debug=] )
"

src_test() {
	local VIRTUALX_COMMAND="qt5-build_src_test"
	virtualmake
}
