# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fudge/fudge-1.0.3-r1.ebuild,v 1.1 2013/06/07 15:17:52 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy2_0)

inherit distutils-r1

DESCRIPTION="Replace real objects with fakes (mocks, stubs, etc) while testing."
HOMEPAGE="http://farmdev.com/projects/fudge/ http://pypi.python.org/pypi/fudge"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"
RDEPEND=""
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	find -name "._*" -print0 | xargs -0 rm -f
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C docs html
}

python_compile() {
	if ! use test; then
		pushd $"{BUILD_DIR}"/lib > /dev/null
		rm -rf ${PN}/tests/ || die
	fi
	distutils-r1_python_compile
}

python_test() {
	if [[ "${EPYTHON}" == python3* ]]; then
		pushd $"{BUILD_DIR}"../ > /dev/null
		2to3 --no-diffs build/lib/${PN}/tests
	fi
	nosetests -w build/lib/${PN}/tests || die
	rm -rf build/lib/${PN}/tests/ || die
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
