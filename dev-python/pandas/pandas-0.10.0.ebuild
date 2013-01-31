# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.10.0.ebuild,v 1.3 2013/01/31 13:46:39 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Powerful data structures for data analysis and statistics"
HOMEPAGE="http://pandas.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples excel test R"

CDEPEND="
	dev-python/numpy
	dev-python/python-dateutil[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	doc? (
		dev-python/ipython
		dev-python/rpy
		dev-python/sphinx[${PYTHON_USEDEP}]
		sci-libs/scikits_statsmodels
		)
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
RDEPEND="${CDEPEND}
	dev-python/matplotlib
	dev-python/pytables
	dev-python/pytz[${PYTHON_USEDEP}]
	sci-libs/scipy
	excel? (
		dev-python/openpyxl
		dev-python/xlrd
		dev-python/xlwt
	)
	R? ( dev-python/rpy )"

python_compile_all() {
	python_export_best
	if use doc; then
		cd doc
		"${PYTHON}" make.py html || die
	fi
}

python_test() {
	cd "${BUILD_DIR}"/lib* || die
	PYTHONPATH=. MPLCONFIGDIR=. HOME=. nosetests-"${EPYTHON}" pandas || die
}

python_install_all() {
	distutils-r1_python_install
	use doc && dohtml -r doc/build/html
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
