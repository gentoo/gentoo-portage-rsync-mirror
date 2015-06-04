# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyftpdlib/pyftpdlib-0.7.0.ebuild,v 1.15 2015/06/04 08:01:09 jlec Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="ssl(+)"
PYTHON_USE_WITH_OPT="ssl"
SUPPORT_PYTHON_ABIS="1"
# pypy has no spwd.so
PYTHON_TESTS_RESTRICTED_ABIS="2.7-pypy-*"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python FTP server library"
HOMEPAGE="http://code.google.com/p/pyftpdlib/ http://pypi.python.org/pypi/pyftpdlib"
SRC_URI="http://pyftpdlib.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="examples ssl"

DEPEND="ssl? (
	dev-lang/python:2.7
	dev-python/pyopenssl
)"
RDEPEND="${DEPEND}"

DOCS="CREDITS HISTORY"

src_test() {
	testing() {
		for test in test/{test_ftpd.py,test_contrib.py}; do
			PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" $test || die
		done
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo test
	fi
}
