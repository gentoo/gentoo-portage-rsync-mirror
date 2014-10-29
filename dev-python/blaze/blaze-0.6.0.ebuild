# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/blaze/blaze-0.6.0.ebuild,v 1.2 2014/10/29 08:44:59 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Next generation Python numpy"
HOMEPAGE="http://blaze.pydata.org/"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

IUSE="doc examples test"

RDEPEND="
	dev-python/llvmpy[${PYTHON_USEDEP}]
	>=dev-python/blz-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/datashape-0.2[${PYTHON_USEDEP}]
	>=dev-python/dynd-python-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/pykit[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/toolz[${PYTHON_USEDEP}]
	dev-python/cytoolz[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	python_targets_python2_7? ( dev-python/unicodecsv )
	"
DEPEND="${RDEPEND}
	>=dev-python/cython-0.18[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx )
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		  )"

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	"${PYTHON}" -c 'import blaze; blaze.test()' || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html )
	use examples && local EXAMPLES=( samples )
	distutils-r1_python_install_all
}
