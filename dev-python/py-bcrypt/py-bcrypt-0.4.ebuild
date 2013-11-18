# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py-bcrypt/py-bcrypt-0.4.ebuild,v 1.3 2013/11/18 02:45:10 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="py-bcrypt is an implementation of the OpenBSD Blowfish password hashing algorithm"
HOMEPAGE="https://code.google.com/p/py-bcrypt/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
DEPEND=""
RDEPEND=""

DOCS=( LICENSE README TODO )

python_test() {
	distutils_install_for_testing
	"${PYTHON}" test/test.py || die "tests failed"
}
