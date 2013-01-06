# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pdbmat/pdbmat-3.89.ebuild,v 1.3 2012/10/18 17:40:00 jlec Exp $

EAPI=4

inherit cmake-utils fortran-2

DESCRIPTION="Calculate Tirion's model from pdb structures"
HOMEPAGE="http://ecole.modelisation.free.fr/modes.html"
SRC_URI="http://ecole.modelisation.free.fr/enm2011.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

S="${WORKDIR}"/Source_ENM2011

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use examples EXAMPLES)
	)
	cmake-utils_src_configure
}
