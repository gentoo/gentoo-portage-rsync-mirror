# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-1.2.0.ebuild,v 1.6 2013/01/09 22:10:03 jlec Exp $

EAPI="3"

PYTHON_DEPEND="*:2.6"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.3 *-jython 2.7-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="2.[56] 3.1"
PYTHON_CFLAGS=("2.* + -fno-strict-aliasing" "3.* + -fno-strict-aliasing")
PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing" "3.* + -fno-strict-aliasing")
PYTHON_MODNAME="matplotlib mpl_toolkits pylab.py"

WX_GTK_VER="2.8"

inherit distutils eutils

DESCRIPTION="Pure python plotting library with matlab like syntax"
HOMEPAGE="http://matplotlib.org/ http://pypi.python.org/pypi/matplotlib"
SRC_URI="mirror://github/${PN}/${PN}/${P}.tar.gz"

IUSE="cairo doc excel examples fltk gtk latex qt4 test tk wxwidgets"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

# Main license: matplotlib
# Some modules: BSD
# matplotlib/backends/qt4_editor: MIT
# Fonts: BitstreamVera, OFL-1.1
LICENSE="BitstreamVera BSD matplotlib MIT OFL-1.1"

CDEPEND="dev-python/numpy
	dev-python/python-dateutil
	dev-python/pytz
	media-libs/freetype:2
	media-libs/libpng
	gtk? ( dev-python/pygtk
	|| ( >=dev-lang/python-3.2 dev-python/pygtk:3 ) )
	wxwidgets? ( dev-python/wxpython:2.8 )"

# internal copy of pycxx highly patched
#	dev-python/pycxx

DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? (
		app-text/dvipng
		dev-python/imaging
		dev-python/ipython
		dev-python/xlwt
		dev-python/sphinx
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
		media-gfx/graphviz[cairo]
	)
	test? ( dev-python/nose )"

RDEPEND="${CDEPEND}
	virtual/pyparsing
	cairo? ( dev-python/pycairo )
	excel? ( dev-python/xlwt )
	fltk? ( dev-python/pyfltk )
	latex? (
		virtual/latex-base
		app-text/ghostscript-gpl
		app-text/dvipng
		app-text/poppler[utils]
		dev-texlive/texlive-fontsrecommended
	)
	qt4? ( || ( dev-python/PyQt4[X] dev-python/pyside[X] ) )"

RESTRICT="mirror"

use_setup() {
	local uword="${2:-${1}}"
	if use ${1}; then
		echo "${uword} = True"
		echo "${uword}agg = True"
	else
		echo "${uword} = False"
		echo "${uword}agg = False"
	fi
}

src_prepare() {
	# create setup.cfg (see setup.cfg.template for any changes)
	cat > setup.cfg <<-EOF
		[provide_packages]
		pytz = False
		dateutil = False
		six = False
		[gui_support]
		$(use_setup cairo)
		$(use_setup fltk)
		$(use_setup gtk)
		$(use_setup qt4)
		$(use_setup tk)
		$(use_setup wxwidgets wx)
	EOF

	# avoid checks needing a X display
	epatch "${FILESDIR}"/${P}-setup.patch

	# Fix test, issue no. 1532
	epatch "${FILESDIR}"/${P}-ft-refcount.patch

	# remove internal copies of pyparsing
	rm lib/matplotlib/pyparsing{_py2,_py3}.py || die
	sed -i -e 's/matplotlib.pyparsing_py[23]/pyparsing/g' \
		lib/matplotlib/{mathtext,fontconfig_pattern}.py \
		|| die "sed pyparsing failed"

	DocCheck() {
	if [[ "$(python_get_version  --major)" == '3' ]] && use doc; then
		eerror ""
		eerror "Building of docs with python3 currently **FAILS**"
		eerror "Docs can be built effectively with python2."
		eerror "eselect python2 and recommence emerge "
		eerror ""
		die
	fi
	}
	python_execute_function DocCheck
	distutils_src_prepare
}

src_compile() {
	unset DISPLAY # bug #278524
	distutils_src_compile
	if use doc; then
		pushd doc > /dev/null
		VARTEXFONTS="${T}"/fonts \
			PYTHONPATH=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*) \
			./make.py --small all
		[[ -e build/latex/Matplotlib.pdf ]] || die "doc generation failed"
		popd > /dev/null
	fi
}

src_test() {
	# if doc was enabled, all examples were built and tested
	use doc && return
	testing() {
		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" install \
			--home="${S}/test-${PYTHON_ABI}" --no-compile \
			|| die "install test failed"
		pushd "${S}/test-${PYTHON_ABI}/"lib* > /dev/null
		PYTHONPATH=python \
			"$(PYTHON)" -c "import matplotlib as m; m.test(verbosity=2)" \
			2>&1 | tee test.log
		grep -Eq "^(ERROR|FAIL):" test.log && return 1
		popd > /dev/null
		rm -r test-${PYTHON_ABI}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/build/latex/Matplotlib.pdf doc/build/html || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
