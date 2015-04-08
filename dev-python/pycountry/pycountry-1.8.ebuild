# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycountry/pycountry-1.8.ebuild,v 1.4 2015/04/02 18:38:44 mr_bones_ Exp $

EAPI=5
# pypy pending actioning of bug filed upstream
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="ISO country, subdivision, language, currency and script definitions and their translations"
HOMEPAGE="http://pypi.python.org/pypi/pycountry"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~ppc ~x86"
IUSE="test"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
DISTUTILS_IN_SOURCE_BUILD=1
DOCS=( HISTORY.txt README TODO.txt )

python_test() {
	# https://bitbucket.org/techtonik/pycountry/issue/8/test_locales-pycountry-015-pypy
	# and STILL
	pushd "${BUILD_DIR}"/lib > /dev/null
	if [[ "${EPYTHON}" == pypy ]]; then
		sed -e 's:test_locales:_&:' -i pycountry/tests/test_general.py || die
	fi
		py.test ${PN}/tests/test_general.py || die
	popd > /dev/null
}
