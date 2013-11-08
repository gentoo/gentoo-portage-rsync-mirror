# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-0.3.2.ebuild,v 1.2 2013/11/08 03:38:03 prometheanfire Exp $

EAPI=5
#restricted due to shitty httpretty dep
RESTRICT="test"
#PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

#because fuck packaging this shit, I mean, really look at this shit.
#https://github.com/gabrielfalcao/HTTPretty/blob/b5827151ddde2e3fed49f5a1ca7f2bb2ef8876a1/requirements.txt
#https://github.com/openstack/python-keystoneclient/blob/0.3.2/test-requirements.txt
#https://bugs.launchpad.net/python-keystoneclient/+bug/1243528
#				>=dev-python/httpretty-0.6.3[${PYTHON_USEDEP}]
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
				<dev-python/hacking-0.7[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.12[${PYTHON_USEDEP}]
				>=dev-python/keyring-1.6.1[${PYTHON_USEDEP}]
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
				>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
				<dev-python/webob-1.3[${PYTHON_USEDEP}]
				>=dev-python/Babel-0.9.6[${PYTHON_USEDEP}] )"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.1.0[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]"

PATCHES=(
)
#	"${FILESDIR}/0.2.3-CVE-2013-2104.patch"

python_test() {
	"${PYTHON}" setup.py nosetests || die
}
