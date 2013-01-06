# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-netstoremanager/leechcraft-netstoremanager-0.5.90.ebuild,v 1.1 2012/12/25 16:47:58 maksbotan Exp $

EAPI=4

inherit leechcraft

DESCRIPTION="LeechCraft plugin for supporting and managing Internet data storages like Yandex.Disk"

SLOT="0"
KEYWORDS="~amd64 ~x86"
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
