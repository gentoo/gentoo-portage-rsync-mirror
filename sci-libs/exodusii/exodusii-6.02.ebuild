# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/exodusii/exodusii-6.02.ebuild,v 1.4 2015/03/09 00:05:49 pacho Exp $

EAPI=5

inherit cmake-utils multilib

MY_PN="${PN%ii}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Model developed to store and retrieve transient data for finite element analyses"
HOMEPAGE="http://sourceforge.net/projects/exodusii/"
SRC_URI="mirror://sourceforge/project/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE="static-libs test"

DEPEND="sci-libs/netcdf[hdf5]"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}/${MY_PN}

PATCHES=( "${FILESDIR}"/${PN}-5.26-multilib.patch )

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DNETCDF_DIR="${EPREFIX}/usr/"
		$(cmake-utils_use_build !static-libs SHARED)
		$(cmake-utils_use_build test TESTING)
	)
	cmake-utils_src_configure
}

src_test() {
	cd "${BUILD_DIR}"/cbind/test || die
	ctest || die
	cd "${BUILD_DIR}"/forbind/test || die
	emake f_check
}
