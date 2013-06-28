# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openmm/openmm-5.1-r2.ebuild,v 1.3 2013/06/28 01:30:51 ottxor Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit cmake-utils cuda multilib python-any-r1

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
	wrappers? (
		dev-cpp/gccxml
		virtual/jre
		${PYTHON_DEPS}
		app-doc/doxygen )" # wrappers need doxygen #470706

S="${WORKDIR}/${MY_P}"

src_prepare() {
	use cuda && cuda_src_prepare

	#475002
	find . -name CMakeLists.txt -exec sed -i \
		-e "/INSTALL/s@\(DESTINATION\|RUNTIME\)\(.*\)lib@\1\2$(get_libdir)@" \
		-e "/INSTALL_TARGETS/s@lib\(.*RUNTIME\)@$(get_libdir)\1@" \
		{} + || die

	default
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use cuda OPENMM_BUILD_CUDA_LIB)
		$(cmake-utils_use opencl OPENMM_BUILD_OPENCL_LIB)
		$(cmake-utils_use doc OPENMM_GENERATE_API_DOCS)
		$(cmake-utils_use wrappers OPENMM_BUILD_C_AND_FORTRAN_WRAPPERS)
		$(cmake-utils_use wrappers OPENMM_BUILD_PYTHON_WRAPPERS)
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
