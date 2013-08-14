# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksudoku/ksudoku-4.11.0.ebuild,v 1.1 2013/08/14 20:23:25 dilfridge Exp $

EAPI=5

KDE_HANDBOOK="optional"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="KDE Sudoku"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdegames)
	opengl? ( virtual/glu )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with opengl OpenGL)
	)
	kde4-base_src_configure
}
