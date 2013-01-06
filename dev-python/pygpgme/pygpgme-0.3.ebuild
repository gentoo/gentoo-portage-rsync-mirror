# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygpgme/pygpgme-0.3.ebuild,v 1.4 2012/08/09 08:13:49 patrick Exp $

EAPI=4
PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[56] 3.1 *-pypy-* *-jython"

inherit distutils

DESCRIPTION="A Python wrapper for the GPGME library"
HOMEPAGE="https://launchpad.net/pygpgme"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-crypt/gpgme"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's/#include <gpgme\.h>/#include <gpgme\/gpgme\.h>/' \
		-i "${S}/src/pygpgme.h" || die
	sed -e 's/suite.addTest(tests.test_sign_verify.test_suite())/#\0/' \
		-e 's/suite.addTest(tests.test_encrypt_decrypt.test_suite())/#\0/' \
		-e 's/suite.addTest(tests.test_passphrase.test_suite())/#\0/' \
		-i "${S}/tests/__init__.py" || die
	distutils_src_prepare
}
