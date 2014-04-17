# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/analitza/analitza-4.13.0.ebuild,v 1.2 2014/04/17 00:43:13 johu Exp $

EAPI=5

KDE_HANDBOOK="never"
OPENGL_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="KDE library for mathematical features"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug readline"

DEPEND="
	opengl? ( virtual/glu )
	readline? ( sys-libs/readline )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with readline)
	)

	kde4-base_src_configure
}
