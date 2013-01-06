# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstars/kstars-4.9.4.ebuild,v 1.2 2012/12/23 19:35:41 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
inherit flag-o-matic kde4-base

DESCRIPTION="KDE Desktop Planetarium"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug fits indi"

DEPEND="
	dev-cpp/eigen:2
	$(add_kdebase_dep libkdeedu)
	fits? ( >=sci-libs/cfitsio-0.390 )
	indi? ( >=sci-libs/indilib-0.9.1 )
"
RDEPEND="${DEPEND}"

src_configure() {
	# Bug 308903
	use ppc64 && append-flags -mminimal-toc

	mycmakeargs=(
		$(cmake-utils_use_with fits CFitsio)
		$(cmake-utils_use_with indi)
	)

	kde4-base_src_configure
}
