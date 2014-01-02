# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hacking/hacking-0.7.2-r1.ebuild,v 1.1 2014/01/02 15:06:38 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2} )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Nova API"
HOMEPAGE="https://github.com/openstack-dev/hacking"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
			>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
			dev-python/subunit[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/testrepository-0.0.17-r2[${PYTHON_USEDEP}]
			>=dev-python/testscenarios-0.4[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
			${RDEPEND} )"
RDEPEND="~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		>=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
		<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
		~dev-python/flake8-2.0[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"
DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	# https://bugs.launchpad.net/hacking/+bug/1265520
	if [ "${EPYTHON}" == 'python3.2' ]; then
		sed -e 's:test_pep8:_&:' -i hacking/tests/test_doctest.py || die
		sed -e 's:test_with_physical_line_argument:_&:' \
			-e 's:test_without_physical_line_argument:_&:' \
			-i hacking/tests/test_noqa_decorator.py || die
	fi
	testr init || die "testr init died"
	testr run || die "testsuite failed under ${EPYTHON}"

	flake8 "${PN}"/tests || die "flake8 drew error on a run over ${PN}/tests folder"
}
