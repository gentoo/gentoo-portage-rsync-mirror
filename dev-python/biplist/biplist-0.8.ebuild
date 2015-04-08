# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/biplist/biplist-0.8.ebuild,v 1.3 2015/03/08 23:40:18 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="http://pypi.python.org/pypi/biplist/ https://github.com/wooster/biplist"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="amd64 x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		${RDEPEND} )"

python_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
