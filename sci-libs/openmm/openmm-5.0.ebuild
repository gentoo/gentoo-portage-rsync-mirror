# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openmm/openmm-5.0.ebuild,v 1.1 2013/02/05 05:51:44 ottxor Exp $

EAPI="5"

PYTHON_DEPEND="2:2.6"

inherit cmake-utils cuda python

MY_P="${PN^^[om]}${PV}-Source"
DESCRIPTION="provides tools for modern molecular modeling simulation"
HOMEPAGE="https://simtk.org/home/openmm"
SRC_URI="mirror://gentoo/${MY_P}.zip"

LICENSE="MIT LGPL-2.1+ BSD RU-BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda doc examples opencl wrappers"

RDEPEND="
	cuda? ( >=dev-util/nvidia-cuda-toolkit-4.2.9-r1 )
	opencl? ( virtual/opencl )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	wrappers? ( dev-cpp/gccxml virtual/jre )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	use cuda && cuda_src_prepare
	default
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use cuda OPENMM_BUILD_CUDA_LIB)
		$(cmake-utils_use opencl OPENMM_BUILD_OPENCL_LIB)
		$(cmake-utils_use doc OPENMM_GENERATE_API_DOCS)
		$(cmake-utils_use wrappers OPENMM_BUILD_C_AND_FORTRAN_WRAPPERS)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use doc; then
		dodoc "${ED}"/usr/docs/*.pdf
		dohtml -r "${ED}"/usr/docs/*.html "${ED}"/usr/docs/api-*
	fi
	rm -f "${ED}"/usr/docs/*.pdf
	rm -rf "${ED}"/usr/docs/*.html "${ED}"/usr/docs/api-*
	rmdir "${ED}"/usr/docs || die

	if use examples; then
		insinto /usr/share/"${PN}"
		doins -r "${ED}"/usr/examples
	fi
	rm -rf "${ED}"/usr/examples

	rm -rf "${ED}"/usr/licenses
}
