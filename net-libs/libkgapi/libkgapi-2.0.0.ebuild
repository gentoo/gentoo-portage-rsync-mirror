# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkgapi/libkgapi-2.0.0.ebuild,v 1.2 2013/05/30 11:47:12 kensington Exp $

EAPI=5

KDE_LINGUAS=""
inherit kde4-base

SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
DESCRIPTION="Library for accessing Google calendar and contact resources"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkgapi"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="oldpim"
SLOT=4

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	dev-libs/qjson
	oldpim? ( dev-libs/boost )
	!oldpim? ( $(add_kdebase_dep kdepimlibs 'semantic-desktop(+)' 4.6.0) )
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		-DKGAPI_DISABLE_DEPRECATED=FALSE
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
