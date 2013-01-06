# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/passlib/passlib-1.6.1.ebuild,v 1.2 2013/01/01 06:22:20 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

DESCRIPTION="comprehensive password hashing framework supporting over 20
schemes"
HOMEPAGE="http://code.google.com/p/passlib/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test doc"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose )"
RDEPEND=""

python_test() {
	"${PYTHON}" setup.py nosetests || die
}

python_install() {
	distutils-r1_python_install
	if use doc; then
		dodoc "${S}"/docs/*.rst
		dodoc "${S}"/docs/requirements.txt
		dodoc "${S}"/docs/lib/*.rst
	fi
}
