# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.10_beta1-r1.ebuild,v 1.4 2014/03/31 21:01:05 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1

MY_P="${P/_beta/b}"

DESCRIPTION="A CSS Cascading Style Sheets library"
HOMEPAGE="http://pypi.python.org/pypi/cssutils/ https://bitbucket.org/cthedot/cssutils"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	# Disable test failing with dev-python/pyxml installed.
	if has_version dev-python/pyxml; then
		sed -e "s/test_linecol/_&/" -i src/tests/test_errorhandler.py
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	if [[ "${EPYTHON}" == python2* || "${EPYTHON}" == 'pypy pypy2_0' ]]; then
		pushd "${BUILD_DIR}"/../ > /dev/null
		nosetests src/tests/test_*.py || die "Tests failed under ${EPYTHON}"
	else
		pushd "${BUILD_DIR}"/
		ln -sf ../sheets .
		cd lib || die
		nosetests tests/test_*.py || die "Tests failed under ${EPYTHON}"
	fi
}

python_install() {
	distutils-r1_python_install
	# Don't install py3 stuff on py2. Breaks py25
	if [[ "${EPYTHON}" != python3.* ]]; then
		rm -f "${D}$(python_get_sitedir)/cssutils/_codec3.py" || die
	fi

	# Don't install tests
	rm -r "${D}$(python_get_sitedir)/tests" || die
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
