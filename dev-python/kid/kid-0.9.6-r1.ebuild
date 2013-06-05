# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kid/kid-0.9.6-r1.ebuild,v 1.1 2013/06/05 05:57:23 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A simple and Pythonic XML template language"
HOMEPAGE="http://www.kid-templating.org/ http://pypi.python.org/pypi/kid"
SRC_URI="http://www.kid-templating.org/dist/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples test"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/docutils[${PYTHON_USEDEP}] )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS=( README doc/{guide.txt,index.txt,notes.txt} )

python_prepare_all() {
	use test && DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc
}

python_test() {
	py.test -xl || die
}

python_install_all() {
#	dobin bin/*

	use doc && local HTML_DOCS=( doc/html/. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
