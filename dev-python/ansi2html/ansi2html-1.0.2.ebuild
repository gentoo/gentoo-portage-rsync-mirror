# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ansi2html/ansi2html-1.0.2.ebuild,v 1.1 2013/10/04 21:13:24 sping Exp $

EAPI=5

# ordereddict is need for < 2.7, but it's not packaged (yet)
PYTHON_COMPAT=( python{2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Convert text with ANSI color codes to HTML"
HOMEPAGE="http://pypi.python.org/pypi/ansi2html https://github.com/ralphbean/ansi2html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	nosetests -w tests \
		|| die "Tests fail with ${EPYTHON}"
}
