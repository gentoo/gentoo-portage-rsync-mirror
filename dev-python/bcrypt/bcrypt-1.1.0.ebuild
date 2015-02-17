# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bcrypt/bcrypt-1.1.0.ebuild,v 1.1 2015/02/17 11:14:53 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{2,3,4} pypy )

inherit distutils-r1

DESCRIPTION="Modern password hashing for software and servers"
HOMEPAGE="https://github.com/pyca/bcrypt/ https://pypi.python.org/pypi/bcrypt/"
SRC_URI="
	https://github.com/pyca/bcrypt/archive/v${PV}.tar.gz -> ${P}.tar.gz
	mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		)"
RDEPEND="
	>=dev-python/cffi-0.8:=[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	!dev-python/py-bcrypt"

DISTUTILS_IN_SOURCE_BUILD=1

python_test() {
	esetup.py test
}
