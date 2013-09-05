# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mocker/mocker-1.1.1-r1.ebuild,v 1.2 2013/09/05 18:46:39 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Platform for Python test doubles: mocks, stubs, fakes, and dummies"
HOMEPAGE="http://labix.org/mocker http://pypi.python.org/pypi/mocker"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

PYTHON_MODNAME="mocker.py"

src_prepare() {
	epatch "${FILESDIR}"/${P}-pypy_test.patch
}

python_test() {
	"${PYTHON}" test.py || die "Tests failed under ${EPYTHON}"
}
