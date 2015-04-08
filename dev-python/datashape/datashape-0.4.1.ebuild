# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/datashape/datashape-0.4.1.ebuild,v 1.1 2014/11/18 03:45:16 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Language defining a data description protocol"
HOMEPAGE="https://github.com/ContinuumIO/datashape"
SRC_URI="https://github.com/ContinuumIO/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/multipledispatch[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]"
DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Prevent un-needed d'loading
	sed -e "s/'sphinx.ext.intersphinx', //" -i docs/source/conf.py || die

	# https://github.com/ContinuumIO/datashape/issues/115
	sed -e "s/from_numpy, error/&\nfrom datashape.internal_utils import raises/" \
		-i ${PN}/tests/test_coretypes.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_test() {
	py.test -v || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/build/html/. )
	distutils-r1_python_install_all
}
