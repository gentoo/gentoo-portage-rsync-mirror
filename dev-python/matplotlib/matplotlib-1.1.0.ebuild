# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/matplotlib/matplotlib-1.1.0.ebuild,v 1.16 2013/01/06 19:20:12 idella4 Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
WX_GTK_VER="2.8"

inherit distutils

DESCRIPTION="Pure python plotting library with matlab like syntax"
HOMEPAGE="http://matplotlib.sourceforge.net/ http://pypi.python.org/pypi/matplotlib"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	doc? ( mirror://sourceforge/${PN}/mpl_sampledata-${PV}.tar.gz )
	examples? ( mirror://sourceforge/${PN}/mpl_sampledata-${PV}.tar.gz )"

IUSE="cairo doc excel examples fltk gtk latex qt4 tk wxwidgets"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
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
	gtk? ( dev-python/pygtk )
	wxwidgets? ( dev-python/wxpython:2.8 )"

DEPEND="${CDEPEND}
	dev-python/pycxx
	virtual/pkgconfig
	doc? (
		app-text/dvipng
		dev-python/imaging
		dev-python/ipython
		dev-python/xlwt
		dev-python/sphinx
		media-gfx/graphviz[cairo]
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexrecommended
	)"

RDEPEND="${CDEPEND}
	virtual/ttf-fonts
	media-fonts/stix-fonts
	media-fonts/texcm-ttf
	virtual/pyparsing
	cairo?  ( dev-python/pycairo )
	excel?  ( dev-python/xlwt )
	fltk?   ( dev-python/pyfltk )
	qt4?    ( || ( dev-python/PyQt4[X] dev-python/pyside[X] ) )
	latex?  (
		virtual/latex-base
		app-text/ghostscript-gpl
		app-text/dvipng
		app-text/poppler[utils]
		dev-texlive/texlive-fontsrecommended
	)"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="matplotlib mpl_toolkits pylab.py"

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
		[gui_support]
		$(use_setup cairo)
		$(use_setup fltk)
		$(use_setup gtk)
		$(use_setup qt4)
		$(use_setup tk)
		$(use_setup wxwidgets wx)
	EOF

	# avoid checks needing a X display
	sed -i \
		-e "s/check_for_gtk()/$(use gtk && echo True || echo False)/" \
		-e "s/check_for_tk()/$(use tk && echo True || echo False)/" \
		setup.py || die "sed setup.py failed"

	# respect FHS:
	# - mpl-data in /usr/share/matplotlib
	# - config files in /etc/matplotlib
	sed -i \
		-e "/'mpl-data\/matplotlibrc',/d" \
		-e "/'mpl-data\/matplotlib.conf',/d" \
		-e "s:'lib/matplotlib/mpl-data/matplotlibrc':'matplotlibrc':" \
		-e "s:'lib/matplotlib/mpl-data/matplotlib.conf':'matplotlib.conf':" \
		setup.py || die "sed setup.py for FHS failed"

	# remove internal copies of pycxx, pyparsing
	rm -rf CXX lib/matplotlib/pyparsing.py \
		|| die "removed internal copies failed"

	# bug #334429 https://developer.mozilla.org/en/Mozilla_MathML_Project/Fonts
	# which advise against bakoma fonts
	sed -i \
		-e '/fontset/s/cm/stix/' \
		lib/matplotlib/mpl-data/matplotlib.conf* || die

	sed -i \
		-e 's/matplotlib.pyparsing/pyparsing/g' \
		lib/matplotlib/{mathtext,fontconfig_pattern}.py \
		|| die "sed pyparsing failed"

	# some fixes to avoid fetching data while compiling examples in tests
	if use doc || use examples; then
		cat <<-EOF >> doc/matplotlibrc
			examples.download : False
			examples.directory : ${WORKDIR}/mpl_sampledata-${PV}
		EOF
		cat <<-EOF >> matplotlibrc.template
			examples.download : False
			examples.directory : ${EPREFIX}/usr/share/doc/${PF}/examples
		EOF
	fi
}

src_compile() {
	unset DISPLAY # bug #278524
	distutils_src_compile_pre_hook() {
		ln -fs "${EPREFIX}/usr/share/python$(python_get_version)/CXX" .
	}
	distutils_src_compile

	if use doc; then
		cd "${S}/doc"
		MATPLOTLIBDATA="${S}/lib/matplotlib/mpl-data" \
			VARTEXFONTS="${T}"/fonts \
			PYTHONPATH=$(ls -d "${S}"/build-$(PYTHON -f --ABI)/lib*) \
			"$(PYTHON -f)" make.py --small all
		[[ -e build/latex/Matplotlib.pdf ]] || die "doc generation failed"
	fi
}

src_test() {
	# if doc were enabled, all examples were built and tested
	use doc && return
	einfo "Tests are quite long, be patient"
	cd "${S}/examples/tests"
	testing() {
		PYTHONPATH=$(ls -d "${S}"/build-${PYTHON_ABI}/lib*) \
			"$(PYTHON)" backend_driver.py agg || return 1
		PYTHONPATH=$(ls -d "${S}"/build-${PYTHON_ABI}/lib*) \
			"$(PYTHON)" backend_driver.py --clean
	}
	python_execute_function testing
}

src_install() {
	# remove fonts bundles except some computer modern ones
	rm -f lib/matplotlib/mpl-data/fonts/ttf/cm{ex,mi,r,sy}10.ttf || die
	rm -f lib/matplotlib/mpl-data/fonts/ttf/{Vera*,*.TXT} || die
	rm -rf lib/matplotlib/mpl-data/fonts/{afm,pdfcorefonts} || die

	# sed only after doc building, to allow using default configs
	sed -i \
		-e "s:path =  get_data_path():path = '${EPREFIX}/etc/matplotlib':" \
		-e "s:os.path.dirname(__file__):'${EPREFIX}/usr/share/${PN}':g" \
		build-*/lib*/matplotlib/__init__.py \
		|| die "sed init for FHS failed"
	distutils_src_install

	# respect FHS
	dodir /usr/share/${PN}
	mv "${ED}$(python_get_sitedir -f)/${PN}/"{mpl-data,backends/Matplotlib.nib} \
		"${ED}usr/share/${PN}" || die "Renaming failed"
	rm -fr "${ED}"usr/lib*/*/site-packages/${PN}/{mpl-data,backends/Matplotlib.nib}

	insinto /etc/matplotlib
	doins matplotlibrc matplotlib.conf

	# doc and examples
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/build/latex/Matplotlib.pdf doc/build/html || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${WORKDIR}"/mpl_sampledata-${PV}/* || die
	fi

}
