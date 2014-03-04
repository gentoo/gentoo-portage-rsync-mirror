# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/iso8601/iso8601-0.1.10.ebuild,v 1.3 2014/03/04 20:53:50 naota Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Simple module to parse ISO 8601 dates"
HOMEPAGE="http://code.google.com/p/pyiso8601/ http://pypi.python.org/pypi/iso8601"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( >=dev-python/pytest-2.4.2[${PYTHON_USEDEP}] )"

python_test() {
	"${PYTHON}" -m pytest --verbose ${PN} || die "Tests fail with ${EPYTHON}"
}
