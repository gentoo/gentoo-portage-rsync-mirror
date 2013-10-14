# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/metis/metis-5.1.0.ebuild,v 1.1 2013/10/14 12:38:37 jlec Exp $

EAPI=5

inherit cmake-utils fortran-2

DESCRIPTION="A package for unstructured serial graph partitioning"
HOMEPAGE="http://www-users.cs.umn.edu/~karypis/metis/metis/"
SRC_URI="http://glaros.dtc.umn.edu/gkhome/fetch/sw/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
LICENSE="free-noncomm"
IUSE="doc openmp static-libs"

DEPEND=""
RDEPEND="${DEPEND}
	!sci-libs/parmetis"

DOCS=( manual/manual.pdf )

src_prepare() {
	sed \
		-e 's:-O3::g' \
		-i GKlib/GKlibSystem.cmake || die

	sed \
		-e "s:lib$:$(get_libdir):g" \
		-i libmetis/CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DGKLIB_PATH="${S}"/GKlib
		-DSHARED=TRUE
		$(cmake-utils_use openmp)
	)
	cmake-utils_src_configure
}
