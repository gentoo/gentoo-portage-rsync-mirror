# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solid/solid-4.10.5.ebuild,v 1.5 2013/07/31 18:32:54 johu Exp $

EAPI=5

KMNAME="kde-workspace"
CPPUNIT_REQUIRED="test"
inherit kde4-meta

DESCRIPTION="Solid: the KDE hardware library"
HOMEPAGE="http://solid.kde.org"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug bluetooth networkmanager wicd"

DEPEND="
	networkmanager? ( net-misc/networkmanager )
	wicd? ( net-misc/wicd )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep solid-runtime)
"

PDEPEND="bluetooth? ( net-wireless/bluedevil )"

KMEXTRA="
	libs/solid/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with networkmanager NetworkManager)
		$(cmake-utils_use_build wicd)
	)

	kde4-meta_src_configure
}
