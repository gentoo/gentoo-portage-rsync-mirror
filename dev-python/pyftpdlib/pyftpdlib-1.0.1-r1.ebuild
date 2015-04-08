# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyftpdlib/pyftpdlib-1.0.1-r1.ebuild,v 1.14 2014/07/05 13:10:59 klausman Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy pypy2_0 )
PYTHON_REQ_USE="ssl(+)"
# pypy has no spwd.so

inherit distutils-r1

DESCRIPTION="Python FTP server library"
HOMEPAGE="http://code.google.com/p/pyftpdlib/ http://pypi.python.org/pypi/pyftpdlib"
SRC_URI="http://pyftpdlib.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="examples ssl"

DEPEND="ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

DOCS="CREDITS HISTORY"

#PATCHES=( "${FILESDIR}"/${PN}-1-pypy-test.patch )

python_test() {
	cd "${BUILD_DIR}" || die
	for test in "${S}"/test/test_*.py; do
		"${PYTHON}" "${test}" || die "Testing failed with ${EPYTHON}"
	done
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r demo test
	fi
}
