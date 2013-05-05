# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.10.2.ebuild,v 1.5 2013/05/05 10:14:43 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="semantic-desktop"

DEPEND="$(add_kdebase_dep kdelibs 'semantic-desktop?')"
RDEPEND="${DEPEND}"

# Split out from kdelibs in 4.7.1-r2
add_blocker kdelibs 4.7.1-r1
# Moved here in 4.8
add_blocker activitymanager

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop NepomukCore)
	)
	kde4-base_src_configure
}
