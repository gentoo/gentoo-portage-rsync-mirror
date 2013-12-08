# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepim-runtime/kdepim-runtime-4.11.2-r1.ebuild,v 1.2 2013/12/08 14:08:09 ago Exp $

EAPI=5

KMNAME="kdepim-runtime"
inherit kde4-base

DESCRIPTION="KDE PIM runtime plugin collection"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug facebook google kolab"

RESTRICT="test"
# Would need test programs _testrunner and akonaditest from kdepimlibs, see bug 313233

DEPEND="
	app-misc/strigi
	>=app-office/akonadi-server-1.9.52
	dev-libs/boost:=
	dev-libs/libxml2:2
	dev-libs/libxslt
	>=dev-libs/shared-desktop-ontologies-0.11.0
	$(add_kdebase_dep kdepimlibs)
	x11-misc/shared-mime-info
	facebook? ( net-libs/libkfbapi )
	google? ( >=net-libs/libkgapi-2.0 )
	kolab? ( net-libs/libkolab )
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdepim-icons)
	!kde-misc/akonadi-google
	!kde-misc/akonadi-facebook
"

PATCHES=( "${FILESDIR}/${P}-flags.patch" )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package facebook LibKFbAPI)
		$(cmake-utils_use_find_package google LibKGAPI2)
		$(cmake-utils_use_find_package kolab Libkolab)
		$(cmake-utils_use_find_package kolab Libkolabxml)
	)

	kde4-base_src_configure
}
