# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kactivities/kactivities-4.12.5.ebuild,v 1.5 2014/05/08 07:32:48 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Activity Manager"

KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
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
