# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-keystoneclient/python-keystoneclient-9999.ebuild,v 1.13 2014/09/27 21:20:40 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1 git-2

DESCRIPTION="Client Library for OpenStack Identity"
HOMEPAGE="http://www.openstack.org/"
EGIT_REPO_URI="https://github.com/openstack/python-keystoneclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"

# dev-python/discover not used
# dev-python/discover[${PYTHON_USEDEP}]
CDEPEND="
	>=dev-python/pbr-0.6[${PYTHON_USEDEP}]
	!~dev-python/pbr-0.7[${PYTHON_USEDEP}]
	<dev-python/pbr-1.0[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}
	test? (
		>=dev-python/coverage-3.6[${PYTHON_USEDEP}]
		>=dev-python/fixtures-0.3.14[${PYTHON_USEDEP}]
		>=dev-python/hacking-0.8[${PYTHON_USEDEP}]
		<dev-python/hacking-0.9[${PYTHON_USEDEP}]
		>=dev-python/keyring-2.1[${PYTHON_USEDEP}]
		>=dev-python/lxml-2.3[${PYTHON_USEDEP}]
		>=dev-python/mock-1.0[${PYTHON_USEDEP}]
		>=dev-python/mox3-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/oauthlib-0.6[${PYTHON_USEDEP}]
		>=dev-python/oslo-sphinx-2.2.0[${PYTHON_USEDEP}]
		>=dev-python/pycrypto-2.6[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-0.4.0[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
		!~dev-python/sphinx-1.2.0[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.3[${PYTHON_USEDEP}]
		>=dev-python/testrepository-0.0.18[${PYTHON_USEDEP}]
		>=dev-python/testresources-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/testtools-0.9.34[${PYTHON_USEDEP}]
		>=dev-python/webob-1.2.3[${PYTHON_USEDEP}]
	)
"
RDEPEND="
	${CDEPEND}
	>=dev-python/Babel-1.3[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/netaddr-0.7.12[${PYTHON_USEDEP}]
	>=dev-python/oslo-config-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/prettytable-0.7[${PYTHON_USEDEP}]
	<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
	>=dev-python/requests-1.2.1[${PYTHON_USEDEP}]
	!~dev-python/requests-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/stevedore-1.0.0[${PYTHON_USEDEP}]
"

python_compile_all() {
	use doc && emake -C doc html
}

python_test() {
	rm -rf .testrepository || die "couldn't remove '.testrepository' under ${EPYTHON}"

	testr init || die "testr init failed under ${EPYTHON}"
	testr run || die "testr run failed under ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	use examples && local EXAMPLES=( examples/.)

	distutils-r1_python_install_all
}
