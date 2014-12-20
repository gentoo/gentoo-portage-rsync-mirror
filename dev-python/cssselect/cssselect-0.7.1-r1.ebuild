# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssselect/cssselect-0.7.1-r1.ebuild,v 1.11 2014/12/20 04:50:20 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3} )

inherit distutils-r1

DESCRIPTION="parses CSS3 Selectors and translates them to XPath 1.0"
HOMEPAGE="http://packages.python.org/cssselect/ http://pypi.python.org/pypi/cssselect"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/lxml[${PYTHON_USEDEP}] )"
RDEPEND=""

python_compile_all() {
	if use doc ; then
		"${PYTHON}" setup.py build_sphinx || die
	fi
}

python_test() {
	"${PYTHON}" ${PN}/tests.py -v || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
