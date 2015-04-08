# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mechanize/mechanize-0.2.5-r1.ebuild,v 1.5 2014/05/20 20:56:18 mrueg Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Stateful programmatic web browsing in Python"
HOMEPAGE="http://wwwsearch.sourceforge.net/mechanize/ http://pypi.python.org/pypi/mechanize"
SRC_URI="http://wwwsearch.sourceforge.net/${PN}/src/${P}.tar.gz"

LICENSE="|| ( BSD ZPL )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

python_test() {
	# Ignore warnings (http://github.com/jjlee/mechanize/issues/issue/13).
	# https://github.com/jjlee/mechanize/issues/66
	"${PYTHON}" -W ignore test.py
}

python_install_all() {
	# Fix some paths.
	sed -e "s:../styles/:styles/:g" -i docs/html/* || die "sed failed"
	if use doc; then
		dohtml -r docs/html/ docs/styles
	fi

	distutils-r1_python_install_all
}
