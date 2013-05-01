# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalgebra/kalgebra-4.10.2.ebuild,v 1.4 2013/05/01 11:50:50 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="MathML-based graph calculator for KDE."
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug +plasma readline"

DEPEND="
	$(add_kdebase_dep analitza)
	$(add_kdebase_dep libkdeedu)
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with readline)
		$(cmake-utils_use_with plasma)
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-base_src_configure
}
