# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tox/tox-1.7.1.ebuild,v 1.1 2014/05/03 07:57:37 radhermit Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="virtualenv-based automation of test activities"
HOMEPAGE="http://tox.testrun.org http://pypi.python.org/pypi/tox"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/virtualenv-1.11.2[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	>=dev-python/py-1.4.17[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	distutils_install_for_testing
	py.test -x || die
}

python_install_all() {
	use doc && HTML_DOCS=( "${S}"/doc/_build/html/. )
	distutils-r1_python_install_all
}
