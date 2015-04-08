# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygpgme/pygpgme-0.3-r1.ebuild,v 1.6 2015/03/08 23:56:06 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A Python wrapper for the GPGME library"
HOMEPAGE="https://launchpad.net/pygpgme"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-crypt/gpgme"
RDEPEND="${DEPEND}"

python_prepare_all() {
	sed \
		-e 's/#include <gpgme\.h>/#include <gpgme\/gpgme\.h>/' \
		-i "${S}/src/pygpgme.h" || die
	sed \
		-e 's/suite.addTest(tests.test_sign_verify.test_suite())/#\0/' \
		-e 's/suite.addTest(tests.test_encrypt_decrypt.test_suite())/#\0/' \
		-e 's/suite.addTest(tests.test_passphrase.test_suite())/#\0/' \
		-i "${S}/tests/__init__.py" || die
	distutils-r1_python_prepare_all
}
