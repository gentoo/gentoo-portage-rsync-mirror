# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oauthlib/oauthlib-0.3.0.ebuild,v 1.5 2012/11/20 20:38:35 ago Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"
DISTUTILS_SRC_TEST="nosetests"
# Tests depend on dict order, see https://github.com/idangazit/oauthlib/issues/40
PYTHON_TESTS_RESTRICTED_ABIS="*-pypy-*"

inherit distutils

DESCRIPTION="A generic, spec-compliant, thorough implementation of the OAuth request-signing logic"
HOMEPAGE="https://github.com/idan/oauthlib
	http://pypi.python.org/pypi/oauthlib"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="test"

RDEPEND="dev-python/pycrypto"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( dev-python/unittest2 )"

src_test() {
	touch tests/__init__.py
	distutils_src_test
}

src_install() {
	rm -f tests/__init__.py
	distutils_src_install
}
