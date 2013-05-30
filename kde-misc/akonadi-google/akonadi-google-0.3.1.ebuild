# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-google/akonadi-google-0.3.1.ebuild,v 1.3 2013/05/30 11:43:53 kensington Exp $

EAPI=4

KDE_SCM="git"
EGIT_REPONAME="akonadi-google"
inherit kde4-base

DESCRIPTION="Google services integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/playground/pim/akonadi-google"
SRC_URI="http://www.progdan.cz/wp-content/uploads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="oldpim"

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	dev-libs/libxslt
	dev-libs/qjson
	oldpim? ( dev-libs/boost )
	!oldpim? ( $(add_kdebase_dep kdepimlibs 'semantic-desktop(+)' 4.6.0) )
	!>=kde-base/kdepim-runtime-4.8.50
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use oldpim KCAL)
	)
	kde4-base_src_configure
}
