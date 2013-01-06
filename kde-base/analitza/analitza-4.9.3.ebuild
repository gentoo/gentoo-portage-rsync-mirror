# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/analitza/analitza-4.9.3.ebuild,v 1.4 2012/11/30 15:14:26 ago Exp $

EAPI=4

KDE_HANDBOOK="never"
inherit kde4-base

DESCRIPTION="KDE library for mathematical features"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug readline"

DEPEND="
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

add_blocker kalgebra 4.7.50

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with readline)
	)

	kde4-base_src_configure
}
