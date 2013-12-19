# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-0.4.1.ebuild,v 1.2 2013/12/19 02:05:15 prometheanfire Exp $

EAPI=5
#testsuite has unpretty httpretty deps
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Keystone API"
HOMEPAGE="https://github.com/openstack/python-keystoneclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"
RESTRICT="test"

#Note; https://github.com/gabrielfalcao/HTTPretty/blob/b5827151ddde2e3fed49f5a1ca7f2bb2ef8876a1/requirements.txt
#https://github.com/openstack/python-keystoneclient/blob/0.3.2/test-requirements.txt
#https://bugs.launchpad.net/python-keystoneclient/+bug/1243528
#				>=dev-python/httpretty-0.6.3[${PYTHON_USEDEP}]
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5.21[${PYTHON_USEDEP}]
		<dev-python/pbr-1.0[${PYTHON_USEDEP}]
		test? ( >=dev-python/hacking-0.5.6[${PYTHON_USEDEP}]
				<dev-python/hacking-0.8[${PYTHON_USEDEP}]
				>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
				>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
				>=dev-python/keyring-1.6.1[${PYTHON_USEDEP}]
				<dev-python/keyring-2.0[${PYTHON_USEDEP}]
				>=dev-python/mock-1.0[${PYTHON_USEDEP}]
				>=dev-python/mox-0.5.3[${PYTHON_USEDEP}]
				>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.17[${PYTHON_USEDEP}]
				<dev-python/testtools-0.9.33[${PYTHON_USEDEP}]
				>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
				<dev-python/webob-1.3[${PYTHON_USEDEP}]
			) "

RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		>=dev-python/requests-1.1[${PYTHON_USEDEP}]
		>=dev-python/simplejson-2.0.9[${PYTHON_USEDEP}]
		>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
		>=dev-python/oslo-config-1.2.0[${PYTHON_USEDEP}]
		dev-python/netaddr[${PYTHON_USEDEP}]
		>=dev-python/Babel-1.3[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}"/sphinx_mapping.patch
)

python_compile_all() {
	use doc && emake -C doc html
}

# Made more reliant upon httpretty. python test phase is a w.i.p until httpretty is 'sorted'
python_test() {
	# https://bugs.launchpad.net/python-keystoneclient/+bug/1243528
	# https://bugs.launchpad.net/python-keystoneclient/+bug/1174410; last touched on 
	# 2013-05-29 with 'importance: 	Undecided â Medium' and never worked since.
	sed -e 's:test_encrypt_cache_data:_&:' \
		-e 's:test_no_memcache_protection:_&:' \
		-e 's:test_sign_cache_data:_&:' \
		-i keystoneclient/tests/test_auth_token_middleware.py
	rm -f $(find keystoneclient/tests/v2_0/ -name "test_*") || die
	rm -f $(find keystoneclient/tests/v3/ -name "test_*") || die
	testr init
	testr run || die "testsuite failed under python2.7"
	flake8 tests || die "run over tests folder by flake8 drew error"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && local EXAMPLES=( examples/.)
	distutils-r1_python_install_all
}
