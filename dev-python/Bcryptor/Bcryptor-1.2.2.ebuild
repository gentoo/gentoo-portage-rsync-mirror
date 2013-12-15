# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Bcryptor/Bcryptor-1.2.2.ebuild,v 1.1 2013/12/15 11:24:54 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python wrapper for bcrypt"
HOMEPAGE="http://www.bitbucket.org/ares/bcryptor/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="test"
LICENSE="ISC"
SLOT="0"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/cython[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
	)"
RDEPEND="dev-python/Yamlog[${PYTHON_USEDEP}]"

python_test() {
	nosetests || die "testsuite failed under ${EPYTHON}"
}
