# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-heatclient/python-heatclient-0.2.2-r1.ebuild,v 1.1 2013/09/13 19:36:04 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="This is a client library for Heat built on the Heat orchestration
API."
HOMEPAGE="https://github.com/openstack/python-heatclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/mox[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/nose-exclude[${PYTHON_USEDEP}]
			dev-python/nosexcover[${PYTHON_USEDEP}]
			dev-python/nosehtmloutput[${PYTHON_USEDEP}]
			dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
			~dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2[${PYTHON_USEDEP}]
		<dev-python/python-keystoneclient-0.3[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"

PATCHES=(
)
#	"${FILESDIR}/0.2.3-CVE-2013-2104.patch"

python_test() {
	${PYTHON} setup.py nosetests || die
}
