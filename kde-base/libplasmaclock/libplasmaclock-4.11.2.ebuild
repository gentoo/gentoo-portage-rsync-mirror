# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmaclock/libplasmaclock-4.11.2.ebuild,v 1.5 2013/12/10 19:48:48 ago Exp $

EAPI=5

KMNAME="kde-workspace"
KMMODULE="libs/plasmaclock"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug semantic-desktop"

DEPEND="
	$(add_kdebase_dep kephal)
	semantic-desktop? ( $(add_kdebase_dep kdepimlibs) )
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with semantic-desktop KdepimLibs)
	)

	kde4-meta_src_configure
}
