# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/iso8601/iso8601-0.1.9.ebuild,v 1.1 2014/04/20 23:17:31 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Simple module to parse ISO 8601 dates"
HOMEPAGE="http://code.google.com/p/pyiso8601/ http://pypi.python.org/pypi/iso8601"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-2.4.2[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	"${PYTHON}" -m py.test --verbose iso8601 || die "Tests fail with ${EPYTHON}"
}
