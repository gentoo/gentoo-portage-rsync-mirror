# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkpeople/libkpeople-0.2.1.ebuild,v 1.1 2014/02/22 10:16:11 mrueg Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
KDE_LINGUAS="bs cs da de el fr hu lt nl pt pt_BR sk sl sv uk"
inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/${P}.tar.bz2"
else
	KEYWORDS=""
fi

DESCRIPTION="KDE contact person abstraction library"
HOMEPAGE="https://projects.kde.org/projects/playground/network/libkpeople"

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug examples test"

DEPEND="
	dev-libs/shared-desktop-ontologies
	dev-libs/soprano
	$(add_kdebase_dep nepomuk-core)
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with examples)
	)

	kde4-base_src_configure
}
