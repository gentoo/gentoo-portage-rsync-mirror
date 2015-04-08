# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ansi2html/ansi2html-1.0.7.ebuild,v 1.4 2015/04/04 12:56:41 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Convert text with ANSI color codes to HTML"
HOMEPAGE="http://pypi.python.org/pypi/ansi2html https://github.com/ralphbean/ansi2html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
DEPEND="test? ( ${RDEPEND}
		dev-python/nose[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' python2_7 pypy)
	)
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	chmod -x "${S}"/tests/* || die
	esetup.py check
	esetup.py test
}

python_install_all() {
	doman man/ansi2html.1
	DOCS=(  README.rst man/ansi2html.1.txt )
	distutils-r1_python_install_all
}
