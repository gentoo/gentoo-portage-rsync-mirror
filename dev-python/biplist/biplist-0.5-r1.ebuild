# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/biplist/biplist-0.5-r1.ebuild,v 1.1 2013/05/29 07:02:47 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_6,2_7,3_2,3_3} )
#DISTUTILS_SRC_TEST=nosetests
inherit distutils-r1

DESCRIPTION="A binary plist parser/generator for Python"
HOMEPAGE="http://pypi.python.org/pypi/biplist/ https://github.com/wooster/biplist"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="test"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}] )"

python_test() {
	# https://github.com/wooster/biplist/issues/5
	nosetests || die "Tests failed under ${EPYTHON}"
}
