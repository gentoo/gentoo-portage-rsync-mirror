# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-troveclient/python-troveclient-0.1.4.ebuild,v 1.3 2014/04/28 03:22:38 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="This is a client for the OpenStack Trove API, a scalable relational database service."
HOMEPAGE="https://github.com/openstack/python-troveclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.16[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		test? (	~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
				~dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
				~dev-python/flake8-2.0[${PYTHON_USEDEP}]
				>=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
				<dev-python/hacking-0.7[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]"

python_test() {
	${PYTHON} -m subunit.run discover -t ./ ./troveclient/tests || die
}
