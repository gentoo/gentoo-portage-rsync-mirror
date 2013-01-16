# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.10.0.ebuild,v 1.2 2013/01/16 15:39:16 jlec Exp $

EAPI=4

# python cruft
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
RESTRICT_PYTHON_ABIS="2.4 2.7-pypy-* *-jython 3.*"

inherit distutils

DESCRIPTION="Powerful data structures for data analysis and statistics"
HOMEPAGE="http://pandas.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="doc examples excel R"

CDEPEND="dev-python/numpy
	>=dev-python/python-dateutil-2.1"
DEPEND="${CDEPEND}
	doc? (
		dev-python/ipython
		dev-python/rpy
		dev-python/sphinx
		sci-libs/scikits_statsmodels
	)"
RDEPEND="${CDEPEND}
	dev-python/matplotlib
	dev-python/pytables
	dev-python/pytz
	sci-libs/scipy
	excel? (
		dev-python/openpyxl
		dev-python/xlrd
		dev-python/xlwt
	)
	R? ( dev-python/rpy )"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"$(PYTHON -f)" make.py html || die
	fi
}

src_test() {
	testing() {
		cd "${S}/build-${PYTHON_ABI}"/lib*
		PYTHONPATH=. MPLCONFIGDIR=. HOME=. nosetests-"${PYTHON_ABI}" pandas
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/build/html
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
