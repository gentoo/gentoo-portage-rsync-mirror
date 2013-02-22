# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/h5py/h5py-2.1.2.ebuild,v 1.1 2013/02/22 06:22:37 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 flag-o-matic

DESCRIPTION="A simple Python interface to HDF5 files"
HOMEPAGE="http://h5py.alfven.org/ http://code.google.com/p/h5py/ http://pypi.python.org/pypi/h5py"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sci-libs/hdf5
	dev-python/numpy[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( virtual/python-unittest2[${PYTHON_USEDEP}] )"

python_prepare_all() {
	append-cflags -fno-strict-aliasing
}
