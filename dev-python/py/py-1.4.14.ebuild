# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/py/py-1.4.14.ebuild,v 1.3 2013/09/05 18:46:39 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )
inherit distutils-r1

DESCRIPTION="library with cross-python path, ini-parsing, io, code, log facilities"
HOMEPAGE="http://pylib.readthedocs.org/ http://pypi.python.org/pypi/py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-2[${PYTHON_USEDEP}] )"
RDEPEND=""

DOCS=( CHANGELOG README.txt )

python_test() {
	py.test || die "testing failed with ${EPYTHON}"
}
