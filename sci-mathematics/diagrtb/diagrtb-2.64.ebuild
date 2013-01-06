# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/diagrtb/diagrtb-2.64.ebuild,v 1.1 2012/03/21 13:57:18 jlec Exp $

EAPI=4

inherit cmake-utils fortran-2

DESCRIPTION="Calculation of some eigenvectors of a large real, symmetrical, matrix"
HOMEPAGE="http://ecole.modelisation.free.fr/modes.html"
SRC_URI="http://ecole.modelisation.free.fr/rtb2011.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

S="${WORKDIR}"/Source_RTB2011

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use examples EXAMPLES)
	)
	cmake-utils_src_configure
}
