# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hacking/hacking-0.7.2.ebuild,v 1.1 2013/10/25 06:46:23 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

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
		<dev-python/pbr-1[${PYTHON_USEDEP}]
		test? ( >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				dev-python/subunit[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}] )"
RDEPEND="~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
		>=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
		<dev-python/pyflakes-0.7.4[${PYTHON_USEDEP}]
		~dev-python/flake8-2.0[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m subunit.run discover -t ./ . || die
}
