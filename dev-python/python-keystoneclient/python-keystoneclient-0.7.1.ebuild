# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-0.7.1.ebuild,v 1.1 2014/03/27 21:51:44 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.6[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/hacking-0.8[${PYTHON_USEDEP}]
				<dev-python/hacking-0.9[${PYTHON_USEDEP}]
				>=dev-python/httpretty-0.8.0[${PYTHON_USEDEP}]
				>=dev-python/keyring-1.6.1[${PYTHON_USEDEP}]
				<dev-python/keyring-2.1[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox3-0.7.0[${PYTHON_USEDEP}]
				>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				<dev-python/sphinx-1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
				>=dev-python/testresources-0.2.4[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}]
				>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
			) "

RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.8[${PYTHON_USEDEP}]
		>=dev-python/netaddr-0.7.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.7[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/six-1.5.2[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/sphinx_mapping.patch
)

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	# https://bugs.launchpad.net/python-keystoneclient/+bug/1243528
	testr init
	testr run || die "testsuite failed under python2.7"
	flake8 ${PN/python-/}/tests || die "run over tests folder by flake8 drew error"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && local EXAMPLES=( examples/.)
	distutils-r1_python_install_all
}
