# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-9999.ebuild,v 1.1 2013/12/12 14:30:20 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

PYTHON_REQ_USE='tk?'

inherit distutils-r1 eutils flag-o-matic git-r3 virtualx

DESCRIPTION="Pure python plotting library with matlab like syntax"
HOMEPAGE="http://matplotlib.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/matplotlib/matplotlib.git"

SLOT="0"
# Main license: matplotlib
# Some modules: BSD
# matplotlib/backends/qt4_editor: MIT
# Fonts: BitstreamVera, OFL-1.1
LICENSE="BitstreamVera BSD matplotlib MIT OFL-1.1"
KEYWORDS=""
IUSE="cairo doc excel examples fltk gtk gtk3 latex pyside qt4 test tk wxwidgets"

# #456704 -- a lot of py2-only deps
PY2_USEDEP=$(python_gen_usedep 'python2*')
PY32_USEDEP=$(python_gen_usedep python3_2)
PY3_USEDEP=$(python_gen_usedep python{3_2,3_3})
COMMON_DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil:0[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	media-fonts/stix-fonts
	media-libs/freetype:2
	media-libs/libpng:0
	gtk? ( dev-python/pygtk[${PY2_USEDEP}] )
	wxwidgets? ( >=dev-python/wxpython-2.8[${PY2_USEDEP}] )"

# internal copy of pycxx highly patched
#	dev-python/pycxx

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? (
		app-text/dvipng
		virtual/python-imaging[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/numpydoc[${PY2_USEDEP}]
		dev-python/xlwt[${PY2_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
		media-gfx/graphviz[cairo]
	)
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

RDEPEND="${COMMON_DEPEND}
	dev-python/pyparsing[${PYTHON_USEDEP}]
	cairo? ( dev-python/pycairo[${PYTHON_USEDEP}] )
	excel? ( dev-python/xlwt[${PY2_USEDEP}] )
	fltk? ( dev-python/pyfltk[${PY2_USEDEP}] )
	gtk3? (
		dev-python/pygobject:3[${PYTHON_USEDEP}]
		x11-libs/gtk+:3[introspection] )
	latex? (
		virtual/latex-base
		app-text/ghostscript-gpl
		app-text/dvipng
		app-text/poppler[utils]
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-xetex
	)
	pyside? ( dev-python/pyside[X,${PY2_USEDEP},${PY32_USEDEP}] )
	qt4? ( dev-python/PyQt4[X,${PYTHON_USEDEP}] )"

PY2_FLAGS="|| ( $(python_gen_useflags python2*) )"
PY32_FLAGS="|| ( $(python_gen_useflags python3_2) )"
REQUIRED_USE="
	doc? ( ${PY2_FLAGS} )
	excel? ( ${PY2_FLAGS} )
	fltk? ( ${PY2_FLAGS} )
	gtk? ( ${PY2_FLAGS} )
	pyside? ( ${PY2_FLAGS} ${PY32_FLAGS} )
	wxwidgets? ( ${PY2_FLAGS} )
	test? (
		cairo fltk latex pyside qt4 tk wxwidgets
		|| ( gtk gtk3 )
		)"

RESTRICT="mirror"

# A few C++ source files are written to srcdir.
# Other than that, the ebuild shall be fit for out-of-source build.
DISTUTILS_IN_SOURCE_BUILD=1

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

python_prepare_all() {
	sed \
		-e 's/matplotlib.pyparsing_py[23]/pyparsing/g' \
		-i lib/matplotlib/{mathtext,fontconfig_pattern}.py \
		|| die "sed pyparsing failed"

	# suggested by upstream
	sed \
		-e '/tol/s:32:35:g' \
		-i lib/matplotlib/tests/test_mathtext.py || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_configure() {
	mkdir -p "${BUILD_DIR}" || die

	# create setup.cfg (see setup.cfg.template for any changes).

	# common switches.
	cat > "${BUILD_DIR}"/setup.cfg <<-EOF
		[directories]
		basedirlist = ${EPREFIX}/usr
		[provide_packages]
		pytz = False
		dateutil = False
		[gui_support]
		agg = True
		$(use_setup cairo)
		$(use_setup pyside)
		$(use_setup qt4)
		$(use_setup tk)
	EOF

	if use gtk3 && use cairo; then
		echo "gtk3cairo = True" >> "${BUILD_DIR}"/setup.cfg || die
	else
		echo "gtk3cairo = False" >> "${BUILD_DIR}"/setup.cfg || die
	fi

	if $(python_is_python3); then
		cat >> "${BUILD_DIR}"/setup.cfg <<-EOF
			six = True
			fltk = False
			fltkagg = False
			gtk = False
			gtkagg = False
			wx = False
			wxagg = False
		EOF
	else
		cat >> "${BUILD_DIR}"/setup.cfg <<-EOF
			six = False
			$(use_setup fltk)
			$(use_setup gtk)
			$(use_setup gtk3)
			$(use_setup wxwidgets wx)
		EOF
	fi
}

wrap_setup() {
	local MPLSETUPCFG=${BUILD_DIR}/setup.cfg
	export MPLSETUPCFG

	# Note: remove build... if switching to out-of-source build
	"${@}" build --build-lib="${BUILD_DIR}"/build/lib
}

python_compile() {
	VIRTUALX_COMMAND="wrap_setup"
	virtualmake distutils-r1_python_compile
}

python_compile_all() {
	if use doc; then
		cd doc || die

		# necessary for in-source build
		local -x PYTHONPATH="${BUILD_DIR}"/build/lib:${PYTHONPATH}

		unset DISPLAY # bug #278524
		VARTEXFONTS="${T}"/fonts \
		"${PYTHON}" ./make.py --small html || die
	fi
}

python_test() {
	VIRTUALX_COMMAND="wrap_setup"
	virtualmake distutils_install_for_testing

	cd "${TMPDIR}" || die
	VIRTUALX_COMMAND="${PYTHON}"
	virtualmake -c "
import sys, matplotlib as m
sys.exit(0 if m.test(verbosity=2) else 1)
" || die "Tests fail with ${EPYTHON}"
}

python_install() {
	wrap_setup distutils-r1_python_install
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )

	distutils-r1_python_install_all

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
