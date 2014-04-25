# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/extras/extras-0.0.3.ebuild,v 1.16 2014/04/25 13:08:29 jer Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Useful extra bits for Python that should be in the standard library"
HOMEPAGE="https://github.com/testing-cabal/extras/ http://pypi.python.org/pypi/extras/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/testtools[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	"${PYTHON}" ${PN}/tests/test_extras.py || die
	einfo "test_extras passed under ${EPYTHON}"
}
