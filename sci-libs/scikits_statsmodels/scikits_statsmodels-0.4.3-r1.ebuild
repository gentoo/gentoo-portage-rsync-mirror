# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits_statsmodels/scikits_statsmodels-0.4.3-r1.ebuild,v 1.2 2013/02/18 18:24:41 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 virtualx

MYPN="${PN/scikits_/}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Statistical computations and models for use with SciPy"
HOMEPAGE="http://statsmodels.sourceforge.net/"
SRC_URI="mirror://pypi/${MYPN:0:1}/${MYPN}/${MYP}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND="
	dev-python/pandas[${PYTHON_USEDEP}]
	sci-libs/scikits[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	examples? ( dev-python/matplotlib[${PYTHON_USEDEP}] )"
DEPEND="
	>=dev-python/cython-0.15.1[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	doc? (
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		>=dev-python/ipython-0.12 )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MYP}"

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	cd "${BUILD_DIR}" || die
	VIRTUALX_COMMAND="nosetests"
	virtualmake --verbosity=3
}

python_install_all() {
	find "${S}" -name \*LICENSE.txt -delete
	use doc && HTML_DOCS=( build/sphinx/html/* )
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
	distutils-r1_python_install_all
}

python_install() {
	distutils-r1_python_install
	rm "${D}"$(python_get_sitedir)/scikits/__init__.py || die
}
