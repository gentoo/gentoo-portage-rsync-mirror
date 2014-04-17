# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.13.0.ebuild,v 1.2 2014/04/17 00:43:30 johu Exp $

EAPI=5

EGIT_BRANCH="KDE/4.13"
inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="semantic-desktop"

DEPEND="$(add_kdebase_dep kdelibs 'semantic-desktop?')"
RDEPEND="
	${DEPEND}
	!kde-base/activitymanager
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop NepomukCore)
	)
	kde4-base_src_configure
}
