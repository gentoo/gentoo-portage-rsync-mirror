# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkgapi/libkgapi-2.0.1.ebuild,v 1.6 2013/08/02 14:33:32 ago Exp $

EAPI=5

KDE_LINGUAS=""
inherit kde4-base

SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
DESCRIPTION="Library for accessing Google calendar and contact resources"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkgapi"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""
SLOT=4

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	dev-libs/qjson
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		-DKGAPI_DISABLE_DEPRECATED=FALSE
		-DKCAL=OFF
	)
	kde4-base_src_configure
}
