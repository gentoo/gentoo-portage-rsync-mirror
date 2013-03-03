# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/starpu/starpu-1.0.5.ebuild,v 1.2 2013/03/02 20:04:56 hwoarang Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
inherit autotools-utils toolchain-funcs

PID=32086

DESCRIPTION="Unified runtime system for heterogeneous multicore architectures"
HOMEPAGE="http://runtime.bordeaux.inria.fr/StarPU/"
SRC_URI="https://gforge.inria.fr/frs/download.php/${PID}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="blas cuda debug doc examples fftw gcc-plugin mpi opencl qt4 static-libs test"

RDEPEND="
	sys-apps/hwloc
	sci-mathematics/glpk
	blas? ( virtual/blas )
	cuda? ( x11-drivers/nvidia-drivers dev-util/nvidia-cuda-toolkit )
	fftw? ( sci-libs/fftw:3.0 )
	mpi? ( virtual/mpi )
	opencl? ( virtual/opencl )
	qt4? (  >=dev-qt/qtgui-4.7:4
			>=dev-qt/qtopengl-4.7:4
			>=dev-qt/qtsql-4.7:4
			x11-libs/qwt )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	test? ( gcc-plugin? ( dev-scheme/guile ) )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.0.1-respect-cflags.patch
	"${FILESDIR}"/${PN}-1.0.1-system-blas.patch
	"${FILESDIR}"/${PN}-1.0.1-no-pc-ldflags.patch
)

src_configure() {
	use blas && export BLAS_LIBS="$($(tc-getPKG_CONFIG) --libs blas)"
	local myeconfargs=(
		$(use_enable cuda)
		$(use_enable debug)
		$(use_enable examples build-examples)
		$(use_enable fftw starpufft)
		$(use_enable gcc-plugin gcc-extensions)
		$(use_enable opencl)
		$(use_enable qt4 starpu-top)
		$(use_with mpi mpicc "$(type -P mpicc)")
		$(use mpi && use_enable test mpi-check)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc doc/*.pdf
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
