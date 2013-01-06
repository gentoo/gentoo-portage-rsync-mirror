# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ball/ball-1.4.1.ebuild,v 1.3 2012/12/13 10:58:27 jlec Exp $

EAPI=4

PYTHON_DEPEND="python? 2"

inherit cmake-utils python

DESCRIPTION="Biochemical Algorithms Library"
HOMEPAGE="http://www.ball-project.org/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2 GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="cuda mpi +python sql +threads +webkit"

RDEPEND="
	dev-cpp/eigen:3
	dev-libs/boost
	media-libs/glew
	sci-libs/fftw:3.0[threads?]
	sci-libs/gsl
	sci-libs/libsvm
	sci-mathematics/lpsolve
	virtual/opengl
	x11-libs/libX11
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-test:4
	x11-libs/qt-webkit:4
	cuda? ( dev-util/nvidia-cuda-toolkit )
	mpi? ( virtual/mpi )
	sql? ( x11-libs/qt-sql:4 )
	webkit? ( x11-libs/qt-webkit:4 )"
DEPEND="${RDEPEND}
	dev-python/sip
	sys-devel/bison
	virtual/yacc"

S="${WORKDIR}"/BALL

PATCHES=(
	"${FILESDIR}"/${P}-multilib.patch
	"${FILESDIR}"/${P}-libsvm.patch
	"${FILESDIR}"/${P}-pthread.patch
	"${FILESDIR}"/${P}-python.patch
	"${FILESDIR}"/${P}-missing-signed.patch
	"${FILESDIR}"/${P}-gcc-4.7.patch
	)

pkg_setup() {
	use python \
		&& python_set_active_version 2 \
		&& python_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use threads FFTW_THREADS)
		$(cmake-utils_use cuda MT_ENABLE_CUDA)
		$(cmake-utils_use mpi MT_ENABLE_MPI)
		$(cmake-utils_use sql BALL_HAS_QTSQL)
		$(cmake-utils_use_use webkit USE_QTWEBKIT)
		$(cmake-utils_use python BALL_PYTHON_SUPPORT)
	)
	cmake-utils_src_configure
}
