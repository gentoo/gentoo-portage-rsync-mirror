# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-cinderclient/python-cinderclient-1.0.7.ebuild,v 1.1 2013/11/30 12:00:24 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Cinder API"
HOMEPAGE="https://launchpad.net/python-cinderclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( >=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
			<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
			=dev-python/flake8-2.0[${PYTHON_USEDEP}]
			>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
			<dev-python/hacking-0.8[${PYTHON_USEDEP}]
			>=dev-python/mock-1.0[${PYTHON_USEDEP}]
			>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			dev-python/subunit[${PYTHON_USEDEP}]
			=dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
			>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
		)"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]"

python_test() {
	testr init
	testr run --parallel || die "tests failed under python2.7"
	flake8 cinderclient/tests || die "run by flake8 over tests folder yielded error"
}
