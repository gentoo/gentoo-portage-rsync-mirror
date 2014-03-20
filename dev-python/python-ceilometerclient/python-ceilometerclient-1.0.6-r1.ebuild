# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-ceilometerclient/python-ceilometerclient-1.0.6-r1.ebuild,v 1.2 2014/03/19 23:09:31 bicatali Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="This is a client library for Ceilometer built on the Ceilometer API."
HOMEPAGE="https://github.com/openstack/python-ceilometerclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]
	test? ( =dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		>=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
		<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
		=dev-python/flake8-2.0[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
		<dev-python/hacking-0.8[${PYTHON_USEDEP}]
		>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
		>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0[${PYTHON_USEDEP}]
		>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
		dev-python/subunit[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
		)"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.3.2[${PYTHON_USEDEP}]"

python_test() {
	testr init
	testr run || die "tests failed under python2.7"
	flake8 ceilometerclient/tests/ || die "run over tests folder by flake8 yielded error"
}
