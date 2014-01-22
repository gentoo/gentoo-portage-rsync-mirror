# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.13.0.ebuild,v 1.1 2014/01/22 07:59:04 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 virtualx

DESCRIPTION="Powerful data structures for data analysis and statistics"
HOMEPAGE="http://pandas.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples excel html test R"

REQUIRED_USE="
	excel? ( !python_targets_python3_2 )
	doc? ( !python_targets_python3_2 )
	R? ( !python_targets_python3_2 )
"

CDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	doc? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-1.6.1[${PYTHON_USEDEP}]
		dev-python/pytables[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/rpy[$(python_gen_usedep 'python2_7')]
		sci-libs/scipy[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/xlrd[$(python_gen_usedep 'python2*')]
		dev-python/xlwt[$(python_gen_usedep 'python2*')]
		sci-libs/scikits_timeseries[$(python_gen_usedep 'python2*')]
		x11-misc/xclip )
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
# dev-python/statsmodels invokes a circular dep
#  hence rm from doc? ( ), again
RDEPEND="${CDEPEND}
	dev-python/numexpr[${PYTHON_USEDEP}]
	dev-python/bottleneck[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pytables[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	excel? (
		>=dev-python/openpyxl-1.6.1[${PYTHON_USEDEP}]
		dev-python/xlrd[$(python_gen_usedep 'python2*')]
		dev-python/xlwt[$(python_gen_usedep 'python2*')]
	)
	html? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		|| ( dev-python/lxml[${PYTHON_USEDEP}]
			 dev-python/html5lib[${PYTHON_USEDEP}] )
	)
	R? ( dev-python/rpy[$(python_gen_usedep 'python2_7')] )"

python_prepare_all() {
	if use doc; then
		# Prevent un-needed download during build
		sed -e 's:^intersphinx_mapping:#intersphinx_mapping:' \
			-e "s:^    'statsmodels:#    'statsmodels:" \
			-e "s:^    'python:#    'python:" \
			-e "s:^}:#}:" \
			-i doc/source/conf.py || die
	fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	# To build docs the need be located in $BUILD_DIR,
	# else PYTHONPATH points to unusable modules.
	if use doc; then
		cd "${BUILD_DIR}"/lib || die
		cp -ar "${S}"/doc . && cd doc || die
		LANG=C PYTHONPATH=. "${EPYTHON}" make.py html || die
	fi
}

python_test() {
	# test can't survive py2.6, alternately patch to skip under unittest2
	if [[ ${EPYTHON} == "python2.6" ]]; then
		rm $(find "${BUILD_DIR}" -name test_array.py) || die
	fi
	cd "${BUILD_DIR}"/lib || die
	PYTHONPATH=. MPLCONFIGDIR=. HOME=. \
		VIRTUALX_COMMAND="nosetests --verbosity=3 pandas" \
		virtualmake || die
}

python_install_all() {
	if use doc; then
		cd  "${BUILD_DIR}"/lib || die
		dohtml -r doc/build/html/*
		einfo "An initial build of docs is absent of references to statsmodels"
		einfo "due to circular dependency. To have them included, emerge"
		einfo "statsmodels next and re-emerge pandas with USE doc"
	fi

	if use examples; then
		# example python modules not to be compressed
		docompress -x /usr/share/doc/${PF}/examples
		insinto /usr/share/doc/${PF}
		doins -r "${S}"/examples
	fi
	distutils-r1_python_install_all
}
