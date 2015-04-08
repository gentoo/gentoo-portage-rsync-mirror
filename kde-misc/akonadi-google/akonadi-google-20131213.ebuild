# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-google/akonadi-google-20131213.ebuild,v 1.3 2013/12/30 11:13:38 johu Exp $

EAPI=5

KDE_SCM="git"
inherit kde4-base

EGIT_REPO_URI="git://anongit.kde.org/akonadi-googledata-resource"
DESCRIPTION="Google services integration in Akonadi"
HOMEPAGE="https://projects.kde.org/projects/unmaintained/akonadi-googledata-resource"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop(+)')
	dev-libs/libxslt
	dev-libs/qjson
	>=net-libs/libkgapi-2
	!>=kde-base/kdepim-runtime-4.8.50
"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		-DKCAL=OFF
	)
	kde4-base_src_configure
}
