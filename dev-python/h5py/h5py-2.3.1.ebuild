# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/h5py/h5py-2.3.1.ebuild,v 1.2 2014/07/23 09:01:56 xarthisius Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Simple Python interface to HDF5 files"
HOMEPAGE="http://www.h5py.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test examples mpi"

RDEPEND="
	sci-libs/hdf5
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	mpi? ( dev-python/mpi4py[${PYTHON_USEDEP}] )"
DISTUTILS_NO_PARALLEL_BUILD=1

python_prepare_all() {
	append-cflags -fno-strict-aliasing
	distutils-r1_python_prepare_all
}

python_compile() {
	if use mpi;then
	    export CC=mpicc
		distutils-r1_python_compile --mpi=yes
	else
		distutils-r1_python_compile
	fi
}

python_test() {
	if use mpi ; then
		export CC=mpicc
		esetup.py test --mpi
	else
		esetup.py test
	fi
}

python_install_all() {
	DOCS=( README.rst ANN.rst )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
