# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gnupg/python-gnupg-0.3.2.ebuild,v 1.2 2013/09/05 18:46:54 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Python wrapper for GNU Privacy Guard"
HOMEPAGE="http://code.google.com/p/python-gnupg/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/gnupg"

PATCHES=(
	"${FILESDIR}"/${P}-fast-random.patch
)

python_test() {
	cd "${BUILD_DIR}" || die
	"${PYTHON}" "${S}"/test_gnupg.py || die "Tests fail with ${EPYTHON}"
}
