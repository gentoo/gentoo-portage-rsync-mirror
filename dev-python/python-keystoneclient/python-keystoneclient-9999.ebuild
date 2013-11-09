# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-9999.ebuild,v 1.8 2013/11/09 08:52:41 idella4 Exp $

EAPI=5
#restricted due to packages missing and bad depends in the test ==webob-1.0.8
RESTRICT="test"
#PYTHON_COMPAT=( python2_5 python2_6 python2_7 )
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
EGIT_REPO_URI="https://github.com/openstack/python-keystoneclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/Babel[${PYTHON_USEDEP}]
			dev-python/coverage[${PYTHON_USEDEP}]
			dev-python/fixtures[${PYTHON_USEDEP}]
			dev-python/keyring[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}]
			dev-python/mox[${PYTHON_USEDEP}]
			dev-python/nose[${PYTHON_USEDEP}]
			dev-python/nose-exclude[${PYTHON_USEDEP}]
			dev-python/nosehtmloutput[${PYTHON_USEDEP}]
			dev-python/openstack-nose-plugin[${PYTHON_USEDEP}]
			=dev-python/pep8-1.4.5[${PYTHON_USEDEP}]
			>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
			>=dev-python/testtools-0.9.22[${PYTHON_USEDEP}]
			dev-python/unittest2[${PYTHON_USEDEP}]
			>=dev-python/webob-1.0.8[${PYTHON_USEDEP}] )"
RDEPEND=">=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-0.8.8[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]"

PATCHES=(
)
#	"${FILESDIR}/0.2.3-CVE-2013-2104.patch"

python_test() {
	nosetests || die "testsuite failed"
}
