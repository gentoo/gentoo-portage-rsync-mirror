# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astropy/astropy-0.3.ebuild,v 1.2 2014/02/05 23:50:45 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="http://astropy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="
	dev-libs/expat
	dev-python/numpy[${PYTHON_USEDEP}]
	sci-astronomy/erfa
	sci-astronomy/wcslib
	sci-libs/cfitsio
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/pkgconfig
	doc? ( dev-python/matplotlib
		   dev-python/sphinx
		   media-gfx/graphviz )
	test? (	dev-libs/libxml2
			dev-python/h5py[${PYTHON_USEDEP}]
			dev-python/matplotlib[${PYTHON_USEDEP}]
			dev-python/pytest[${PYTHON_USEDEP}]
			sci-libs/scipy[${PYTHON_USEDEP}] )"

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		python_export_best
		VARTEXFONTS="${T}"/fonts \
			MPLCONFIGDIR="${BUILD_DIR}" \
			PYTHONPATH="${BUILD_DIR}"/lib \
			esetup.py build_sphinx
	fi
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r docs/_build/html
}
