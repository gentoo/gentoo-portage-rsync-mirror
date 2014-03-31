# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/passlib/passlib-1.6.2.ebuild,v 1.2 2014/03/31 20:29:28 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Password hashing framework supporting over 20 schemes"
HOMEPAGE="http://code.google.com/p/passlib/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test doc"

RDEPEND="dev-python/bcrypt[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}]
		)"

python_test() {
	# https://code.google.com/p/passlib/issues/detail?id=50
	nosetests -w "${BUILD_DIR}"/lib \
		-e test_90_django_reference -e test_91_django_generation \
		-e test_77_fuzz_input -e test_config \
		-e test_registry.py \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dodoc docs/{*.rst,requirements.txt,lib/*.rst}
}
