# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pandas/pandas-0.15.0.ebuild,v 1.1 2014/10/26 19:41:19 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 virtualx flag-o-matic

DESCRIPTION="Powerful data structures for data analysis and statistics"
HOMEPAGE="http://pandas.sourceforge.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples excel html test R"

CDEPEND="
	>dev-python/numpy-1.7[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.0[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}
	doc? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/html5lib[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-1.6.1[${PYTHON_USEDEP}]
		<dev-python/openpyxl-2.0[${PYTHON_USEDEP}]
		>=dev-python/pytables-3.0.0[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/rpy[${PYTHON_USEDEP}]
		sci-libs/scipy[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.2.1[${PYTHON_USEDEP}]
		dev-python/xlrd[$(python_gen_usedep 'python2_7')]
		dev-python/xlwt[$(python_gen_usedep 'python2_7')]
		x11-misc/xclip
		)
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"
# dev-python/statsmodels invokes a circular dep
#  hence rm from doc? ( ), again
RDEPEND="${CDEPEND}
	>=dev-python/numexpr-2.1[${PYTHON_USEDEP}]
	dev-python/bottleneck[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pytables[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	sci-libs/scipy[${PYTHON_USEDEP}]
	excel? (
		>=dev-python/openpyxl-1.6.1[${PYTHON_USEDEP}]
		dev-python/xlrd[$(python_gen_usedep 'python2_7')]
		dev-python/xlwt[$(python_gen_usedep 'python2_7')]
	)
	html? (
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
		|| (
			dev-python/lxml[${PYTHON_USEDEP}]
			dev-python/html5lib[${PYTHON_USEDEP}] )
	)
	R? ( dev-python/rpy[${PYTHON_USEDEP}] )"

python_prepare_all() {
	if use doc; then
		# Prevent un-needed download during build
		sed -e "/^              'sphinx.ext.intersphinx',/d" -i doc/source/conf.py || die
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

_python_compile() {
	# https://github.com/pydata/pandas/issues/8033
	if ! python_is_python3; then
		local CFLAGS=${CFLAGS}
		local CXXFLAGS=${CXXFLAGS}
		export CFLAGS
		export CXXFLAGS
		append-cflags -fno-strict-aliasing
		append-cxxflags -fno-strict-aliasing
	fi

	distutils-r1_python_compile
}

src_test() {
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	pushd  "${BUILD_DIR}"/lib > /dev/null
	PYTHONPATH=. MPLCONFIGDIR=. HOME=. \
		nosetests --verbosity=3 -A 'not network and not disabled' pandas \
		|| die "Tests failed under ${EPYTHON}"
	popd > /dev/null
}

python_install_all() {
	if use doc; then
		dodoc -r "${BUILD_DIR}"/lib/doc/build/html
		einfo "An initial build of docs is absent of references to statsmodels"
		einfo "due to circular dependency. To have them included, emerge"
		einfo "statsmodels next and re-emerge pandas with USE doc"
	fi

	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
