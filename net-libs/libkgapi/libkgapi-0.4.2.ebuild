# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkgapi/libkgapi-0.4.2.ebuild,v 1.2 2012/10/17 18:31:27 maekke Exp $

EAPI=4

KDE_LINGUAS=""

inherit kde4-base

SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.bz2"
DESCRIPTION="Library for accessing Google calendar and contact resources"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="oldpim"
SLOT=4

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	dev-libs/qjson
	oldpim? ( dev-libs/boost )
	!oldpim? ( $(add_kdebase_dep kdepimlibs semantic-desktop 4.6.0) )
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
