# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/h5py/h5py-2.2.0.ebuild,v 1.1 2013/09/04 17:22:41 xarthisius Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="Simple Python interface to HDF5 files"
HOMEPAGE="http://www.h5py.org/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test examples"

RDEPEND="
	sci-libs/hdf5:=
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}] )"

python_prepare_all() {
	append-cflags -fno-strict-aliasing
}

python_test() {
	cd "${BUILD_DIR}"/lib/ && nosetests ./${PN}/lowtest || die
}

python_install_all() {
	dodoc README.rst ANN.rst
	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
