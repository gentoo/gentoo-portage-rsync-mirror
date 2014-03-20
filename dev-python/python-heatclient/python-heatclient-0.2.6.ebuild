# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-heatclient/python-heatclient-0.2.6.ebuild,v 1.2 2014/03/19 23:10:06 bicatali Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="This is a client library for Heat built on the Heat orchestration
API."
HOMEPAGE="https://github.com/openstack/python-heatclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( ~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
				~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
				<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
				~dev-python/flake8-2.0[${PYTHON_USEDEP}]
				>=dev-python/hacking-0.8.0[${PYTHON_USEDEP}]
				<dev-python/hacking-0.9[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				>=dev-python/mox3-0.7.0[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
				<dev-python/testscenarios-0.5[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.1.0[${PYTHON_USEDEP}]"

python_compile_all() {
	use doc && sphinx-build -b html -c doc/source/ doc/source/ doc/source/html
}

python_test() {
	testr init
	"${PYTHON}" setup.py testr --coverage
	flake8 heatclient/tests || die "run over tests folder by flake8 yielded error"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/source/html/. )
	distutils-r1_python_install_all
}
