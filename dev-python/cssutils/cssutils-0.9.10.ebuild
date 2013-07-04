# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.10.ebuild,v 1.2 2013/07/04 14:48:26 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A CSS Cascading Style Sheets library"
HOMEPAGE="http://pypi.python.org/pypi/cssutils/ https://bitbucket.org/cthedot/cssutils"
SRC_URI="http://dev.gentoo.org/~idella4/tarballs/${P}-20130704.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# Disable test failing with dev-python/pyxml installed.
	if has_version dev-python/pyxml; then
		sed -e "s/test_linecol/_&/" -i src/tests/test_errorhandler.py
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	# https://bitbucket.org/cthedot/cssutils/issue/35/cssutils-0910-testsuite-fails-from-pypy
	if [[ "${EPYTHON}" == python2* || "${EPYTHON}" == 'pypy2_0' ]]; then
		pushd "${BUILD_DIR}"/../ > /dev/null
		nosetests src/${PN}/tests/test_*.py || die "Tests failed under ${EPYTHON}"
	else
		pushd "${BUILD_DIR}"/
		ln -sf ../sheets .
		cd lib || die
		nosetests ${PN}/tests/test_*.py || die "Tests failed under ${EPYTHON}"
	fi
}

python_install() {
	distutils-r1_python_install
	# Don't install py3 stuff on py2. Breaks py25
	if [[ "${EPYTHON}" != python3.* ]]; then
		rm -f "${D}$(python_get_sitedir)/cssutils/_codec3.py" || die
	fi

	# Don't install tests
	rm -r "${D}$(python_get_sitedir)/${PN}/tests" || die
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
