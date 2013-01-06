# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-netstoremanager/leechcraft-netstoremanager-9999.ebuild,v 1.2 2012/08/10 15:42:50 maksbotan Exp $

EAPI=4

inherit leechcraft

DESCRIPTION="LeechCraft plugin for supporting and managing Internet data storages like Yandex.Disk"

SLOT="0"
KEYWORDS=""
IUSE="+googledrive +yandexdisk"

DEPEND="~net-misc/leechcraft-core-${PV}
	googledrive? (
		dev-libs/qjson
		sys-apps/file
	)"
RDEPEND="${DEPEND}"

src_configure(){
	local mycmakeargs=(
		$(cmake-utils_use_enable googledrive NETSTOREMANAGER_GOOGLEDRIVE)
		$(cmake-utils_use_enable yandexdisk NETSTOREMANAGER_YANDEXDISK)
	)

	cmake-utils_src_configure
}
