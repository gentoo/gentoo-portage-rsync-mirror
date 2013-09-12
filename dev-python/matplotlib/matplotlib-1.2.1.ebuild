# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-1.2.1.ebuild,v 1.6 2013/09/12 22:29:33 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
PYTHON_REQ_USE='tk?'

inherit distutils-r1 eutils flag-o-matic

DESCRIPTION="Pure python plotting library with matlab like syntax"
HOMEPAGE="http://matplotlib.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="cairo doc excel examples fltk gtk gtk3 latex qt4 test tk wxwidgets"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"

# Main license: matplotlib
# Some modules: BSD
# matplotlib/backends/qt4_editor: MIT
# Fonts: BitstreamVera, OFL-1.1
LICENSE="BitstreamVera BSD matplotlib MIT OFL-1.1"

# #456704 -- a lot of py2-only deps
PY2_USEDEP=$(python_gen_usedep 'python2*')
PY32_USEDEP=$(python_gen_usedep python{3_2,3_3})
COMMON_DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	media-fonts/stix-fonts
	media-libs/freetype:2
	media-libs/libpng
	gtk? ( dev-python/pygtk[${PY2_USEDEP}] )
	wxwidgets? ( dev-python/wxpython:2.8[${PY2_USEDEP}] )"

# internal copy of pycxx highly patched
#	dev-python/pycxx

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? (
		app-text/dvipng
		virtual/python-imaging[${PY2_USEDEP},${PY32_USEDEP}]
		dev-python/ipython
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
	gtk3? ( dev-python/pygobject:3[${PYTHON_USEDEP}]
		x11-libs/gtk+:3[introspection] )
	latex? (
		virtual/latex-base
		app-text/ghostscript-gpl
		app-text/dvipng
		app-text/poppler[utils]
		dev-texlive/texlive-fontsrecommended
	)
	qt4? ( || ( dev-python/PyQt4[X,${PYTHON_USEDEP}] dev-python/pyside[X,${PYTHON_USEDEP}] ) )"

PY2_FLAGS="|| ( $(python_gen_useflags python2*) )"
REQUIRED_USE="doc? ( ${PY2_FLAGS} )
	excel? ( ${PY2_FLAGS} )
	fltk? ( ${PY2_FLAGS} )
	gtk? ( ${PY2_FLAGS} )
	wxwidgets? ( ${PY2_FLAGS} )"

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
	# remove internal copies of pyparsing
	rm lib/matplotlib/pyparsing{_py2,_py3}.py || die

	sed -i -e 's/matplotlib.pyparsing_py[23]/pyparsing/g' \
		lib/matplotlib/{mathtext,fontconfig_pattern}.py \
		|| die "sed pyparsing failed"

	local PATCHES=(
		# avoid checks needing a X display
		"${FILESDIR}"/${PN}-1.2.0-setup.patch
	)

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -fno-strict-aliasing
}

python_configure() {
	mkdir -p "${BUILD_DIR}" || die

	# create setup.cfg (see setup.cfg.template for any changes).

	# common switches.
	cat > "${BUILD_DIR}"/setup.cfg <<-EOF || die
		[provide_packages]
		pytz = False
		dateutil = False
		[gui_support]
		$(use_setup cairo)
		$(use_setup qt4)
		$(use_setup tk)
	EOF

	if [[ ${EPYTHON} == python3* ]]; then
		cat >> "${BUILD_DIR}"/setup.cfg <<-EOF || die
			six = True
			fltk = False
			fltkagg = False
			gtk = False
			gtkagg = False
			wx = False
			wxagg = False
		EOF
	else
		cat >> "${BUILD_DIR}"/setup.cfg <<-EOF || die
			six = False
			$(use_setup fltk)
			$(use_setup gtk)
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
	wrap_setup distutils-r1_python_compile
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
	wrap_setup distutils_install_for_testing

	cd "${TMPDIR}" || die
	"${PYTHON}" -c "
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
