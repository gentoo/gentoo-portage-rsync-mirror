# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtnetwork/qtnetwork-5.2.1.ebuild,v 1.1 2014/04/23 07:09:15 patrick Exp $

EAPI=5

QT5_MODULE="qtbase"

inherit qt5-build

DESCRIPTION="The Qt toolkit is a comprehensive C++ application development framework"

if [[ ${QT5_BUILD_TYPE} == live ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi

IUSE="connman networkmanager +ssl"

DEPEND="
	~dev-qt/qtcore-${PV}[debug=]
	sys-libs/zlib
	connman? ( ~dev-qt/qtdbus-${PV}[debug=] )
	networkmanager? ( ~dev-qt/qtdbus-${PV}[debug=] )
	ssl? ( dev-libs/openssl:0 )
"
RDEPEND="${DEPEND}
	connman? ( net-misc/connman )
	networkmanager? ( net-misc/networkmanager )
"

QT5_TARGET_SUBDIRS=(
	src/network
	src/plugins/bearer/generic
)

pkg_setup() {
	qt5-build_pkg_setup

	use connman && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/connman)
	use networkmanager && QT5_TARGET_SUBDIRS+=(src/plugins/bearer/networkmanager)
}

src_configure() {
	local myconf=(
		$(use connman || use networkmanager && echo -dbus-linked || echo -no-dbus)
		$(use ssl && echo -openssl-linked || echo -no-openssl)
	)
	qt5-build_src_configure
}
