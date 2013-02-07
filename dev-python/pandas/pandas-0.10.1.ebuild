# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.10.1.ebuild,v 1.2 2013/02/07 08:52:22 idella4 Exp $

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
		sci-libs/scikits_timeseries
		dev-python/matplotlib
		)
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
# sci-libs/scikits_statsmodels invokes a circular dep, hence rm from doc? ( ), again
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

src_prepare() {
	if use doc; then
		# Prevent un-needed download during build
		sed -e 's:^intersphinx_mapping:#intersphinx_mapping:' \
			-e "s:^    'statsmodels:#    'statsmodels:" \
			-e "s:^    'python:#    'python:" \
			-e "s:^}:#}:" \
			-i doc/source/conf.py || die
	fi

	distutils-r1_src_prepare
}

python_compile_all() {
	python_export_best

	# To build docs the need be located in $BUILD_DIR, else PYTHONPATH points to unusable modules.
	if use doc; then
		cd ${BUILD_DIR}/lib/ || die
		cp -ar "${S}"/doc . && cd doc || die
		PYTHONPATH=. "${PYTHON}" make.py html
	fi
}

python_test() {
	# test can't survive py2.6, alternately patch to skip under unittest2
	if [[ ${EPYTHON} == "python2.6" ]]; then
		rm -f $(find ${BUILD_DIR} -name test_array.py) || die
	fi
	cd "${BUILD_DIR}"/lib/ || die
	PYTHONPATH=. MPLCONFIGDIR=. HOME=. nosetests -v pandas || die
}

python_install_all() {

	if use doc; then
		cd  ${BUILD_DIR}/lib/ || die
		dohtml -r doc/build/html/
		einfo "An initial build of docs are absent of references to scikits_statsmodels"
		einfo "due to circular dependency. To have them included, emerge"
		einfo "scikits_statsmodels next and re-emerge pandas with USE doc"
	fi

	if use examples; then
		# example python modules not to be compressed
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
