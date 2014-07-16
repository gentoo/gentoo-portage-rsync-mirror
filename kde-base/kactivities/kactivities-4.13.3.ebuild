# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.13.3.ebuild,v 1.1 2014/07/16 17:40:54 johu Exp $

EAPI=5

DECLARATIVE_REQUIRED="always"
EGIT_BRANCH="KDE/4.13"
inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="minimal nepomuk"

DEPEND="
	nepomuk? (
		$(add_kdebase_dep nepomuk-core)
		dev-libs/soprano
	)
"
RDEPEND="
	${DEPEND}
	!kde-base/activitymanager
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use minimal KACTIVITIES_LIBRARY_ONLY)
		$(cmake-utils_use_with nepomuk NepomukCore)
	)
	kde4-base_src_configure
}
