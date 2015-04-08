# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkpeople/libkpeople-0.2.2.ebuild,v 1.2 2015/02/12 22:06:09 johu Exp $

EAPI=5

VIRTUALX_REQUIRED="test"
KDE_LINGUAS="bs cs da de fi fr hu lt nl pt pt_BR ro ru sk sl sv uk"
inherit kde4-base

if [[ ${KDE_BUILD_TYPE} != live ]]; then
	KEYWORDS="~amd64 ~x86"
	SRC_URI="mirror://kde/unstable/${PN}/${PV}/src/${P}.tar.bz2"
else
	KEYWORDS=""
fi

DESCRIPTION="KDE contact person abstraction library"
HOMEPAGE="https://projects.kde.org/projects/playground/network/kpeople"

LICENSE="LGPL-2.1"
SLOT="4"
IUSE="debug examples test"

RDEPEND="
	$(add_kdebase_dep kdepimlibs)
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with examples)
	)

	kde4-base_src_configure
}
