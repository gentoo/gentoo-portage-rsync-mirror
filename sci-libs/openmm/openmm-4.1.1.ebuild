# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openmm/openmm-4.1.1.ebuild,v 1.3 2013/01/04 14:55:16 ottxor Exp $

EAPI="5"

inherit cmake-utils

MY_P="${PN^^[om]}${PV}-Source"
DESCRIPTION="provides tools for modern molecular modeling simulation"
HOMEPAGE="https://simtk.org/home/openmm"
SRC_URI="${MY_P}.zip"

LICENSE="MIT LGPL-2.1+ BSD RU-BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda opencl"

RDEPEND="
	cuda? ( dev-util/nvidia-cuda-toolkit )
	opencl? ( virtual/opencl )"
DEPEND="${RDEPEND}
	dev-util/cmake"

RESTRICT="fetch"
S="${WORKDIR}/${MY_P}"

pkg_nofetch(){
	einfo "Please download ${SRC_URI} from"
	einfo "${HOMEPAGE}"
	einfo "and put it into ${DISTDIR}"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use cuda OPENMM_BUILD_CUDA_LIB)
		$(cmake-utils_use opencl OPENMM_BUILD_OPENCL_LIB)
		$(cmake-utils_use !cuda CUDA_BUILD_CUBIN)
		$(cmake-utils_use opencl OPENMM_BUILD_RPMD_PLUGIN)
		$(cmake-utils_use opencl OPENMM_BUILD_PYTHON_WRAPPERS)
	) # last 3 options are workarounds for broken build system

	cmake-utils_src_configure
}
