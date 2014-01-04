# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/passlib/passlib-1.6.1-r1.ebuild,v 1.2 2014/01/04 04:18:02 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Password hashing framework supporting over 20 schemes"
HOMEPAGE="http://code.google.com/p/passlib/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	nosetests -w "${BUILD_DIR}"/lib || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc docs/{*.rst,requirements.txt,lib/*.rst}
}
