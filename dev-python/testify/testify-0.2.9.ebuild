# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/testify/testify-0.2.9.ebuild,v 1.1 2013/01/14 04:06:44 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 3.*"
PYTHON_TESTS_RESTRICTED_ABIS="2.7-pypy-1.*"
inherit eutils distutils vcs-snapshot

DESCRIPTION="A more pythonic replacement for the unittest module and nose"
HOMEPAGE="https://github.com/Yelp/testify http://pypi.python.org/pypi/testify/"
SRC_URI="https://github.com/Yelp/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/pyyaml
	dev-python/sqlalchemy
	www-servers/tornado
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )"
DEPEND="dev-python/setuptools
	test? ( ${RDEPEND} )"

#DOCS="README.txt"

src_prepare() {
	distutils_src_prepare
	# Rm rogue test, Bug #438032
	rm -f test/plugins//http_reporter_test.py
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib/" "$(PYTHON)" bin/${PN} test
	}
	python_execute_function testing
}
