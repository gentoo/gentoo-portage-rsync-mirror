# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-openid/python-openid-2.2.5.ebuild,v 1.9 2014/10/15 23:06:05 blueness Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils eutils

DESCRIPTION="OpenID support for servers and consumers"
HOMEPAGE="http://www.openidenabled.com/openid/libraries/python/ http://pypi.python.org/pypi/python-openid"
# Downloaded from http://github.com/openid/python-openid/downloads
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="examples mysql postgres sqlite test"

RDEPEND="mysql? ( >=dev-python/mysql-python-1.2.2 )
	postgres? ( dev-python/psycopg )
	sqlite? ( || ( dev-lang/python:2.7[sqlite] dev-lang/python:2.6[sqlite] dev-lang/python:2.5[sqlite] dev-python/pysqlite:2 ) )"
DEPEND="${RDEPEND}
	test? ( dev-python/twill
		dev-python/pycurl )"

S="${WORKDIR}/openid-python-openid-b666238"

PYTHON_MODNAME="openid"

src_prepare() {
	distutils_src_prepare

	# Patch to fix confusion with localhost/127.0.0.1
	epatch "${FILESDIR}/${PN}-2.0.0-gentoo-test_fetchers.diff"

	# Disable broken tests from from examples/djopenid.
	sed -e "s/django_failures =.*/django_failures = 0/" -i admin/runtests || die "sed admin/runtests failed"
}

src_test() {
	# Remove test that requires running db server.
	sed -e '/storetest/d' -i admin/runtests

	testing() {
		"$(PYTHON)" admin/runtests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
