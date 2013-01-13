# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/plplot/plplot-5.9.9-r1.ebuild,v 1.7 2013/01/13 12:46:02 jlec Exp $

EAPI=4

WX_GTK_VER="2.8"
PYTHON_DEPEND="python? 2"
FORTRAN_NEEDED=fortran

inherit eutils fortran-2 cmake-utils python toolchain-funcs virtualx \
	wxwidgets java-pkg-opt-2 multilib

DESCRIPTION="Multi-language scientific plotting library"
HOMEPAGE="http://plplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="ada cairo cxx doc dynamic examples fortran gd java jpeg latex lua
	  ocaml octave pdf perl png python qhull qt4 svg tcl test threads tk
	  truetype wxwidgets X"

RDEPEND="
	ada? ( virtual/gnat )
	cairo? ( x11-libs/cairo[svg?,X?] )
	java? ( >=virtual/jre-1.5 )
	gd? ( media-libs/gd[jpeg?,png?] )
	latex? ( virtual/latex-base app-text/ghostscript-gpl )
	lua? ( dev-lang/lua )
	ocaml? (
		dev-lang/ocaml
		dev-ml/camlidl
		cairo? ( dev-ml/cairo-ocaml[gtk] ) )
	octave? ( sci-mathematics/octave )
	pdf? ( media-libs/libharu )
	perl? ( dev-perl/PDL dev-perl/XML-DOM )
	python? (
		dev-python/numpy
		qt4? ( dev-python/PyQt4 ) )
	qhull? ( media-libs/qhull )
	qt4? (
		x11-libs/qt-gui:4
		x11-libs/qt-svg:4 )
	tcl? ( dev-lang/tcl dev-tcltk/itcl
		tk? ( dev-lang/tk dev-tcltk/itk ) )
	truetype? (
				media-fonts/freefont-ttf
				media-libs/lasi
				gd? ( media-libs/gd[truetype] ) )
	wxwidgets? ( x11-libs/wxGTK:2.8[X] x11-libs/agg[truetype?] )
	X? ( x11-libs/libX11 x11-libs/libXau x11-libs/libXdmcp )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	java? ( >=virtual/jdk-1.5 dev-lang/swig )
	ocaml? ( dev-ml/findlib )
	python? ( dev-lang/swig )
	test? ( media-fonts/font-misc-misc
			media-fonts/font-cursor-misc )"
REQUIRED_USE="test? ( latex )"

pkg_setup() {
	use wxwidgets && wxwidgets_pkg_setup
	use python && python_set_active_version 2
	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-tk86.patch
	# path for python independent of python version
	epatch "${FILESDIR}"/${PN}-5.9.6-python.patch
	# test with pdf assumes a modified bundled libharu
	epatch "${FILESDIR}"/${PN}-5.9.9-no-pdftest.patch
	# gentoo bug #419743 fixed upstream
	epatch "${FILESDIR}"/${PN}-5.9.9-CMakeLists.txt.patch

	# avoid installing license
	sed -i -e '/COPYING.LIB/d' CMakeLists.txt || die

	# change default install directories for doc and examples
	sed -i \
		-e 's:${DATA_DIR}/examples:${DOC_DIR}/examples:g' \
		$(find "${S}" -name CMakeLists.txt) || die
	sed -i \
		-e 's:${VERSION}::g' \
		-e "s:doc/\${PACKAGE}:doc/${PF}:" \
		cmake/modules/instdirs.cmake || die
	java-utils-2_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DDEFAULT_ALL_DEVICES=ON
		-DTEST_DYNDRIVERS=OFF
		-DCMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		$(cmake-utils_use_build test)
		$(cmake-utils_use_has python numpy)
		$(cmake-utils_use_with truetype FREETYPE)
		$(cmake-utils_use_enable ada)
		$(cmake-utils_use_enable cxx)
		$(cmake-utils_use_enable dynamic DYNDRIVERS)
		$(cmake-utils_use_enable fortran f77)
		$(cmake-utils_use_enable java)
		$(cmake-utils_use_enable lua)
		$(cmake-utils_use_enable ocaml)
		$(cmake-utils_use_enable octave)
		$(cmake-utils_use_enable perl pdl)
		$(cmake-utils_use_enable python)
		$(cmake-utils_use_enable qt4 qt)
		$(cmake-utils_use_enable tcl)
		$(cmake-utils_use_enable tcl itcl)
		$(cmake-utils_use_enable tk)
		$(cmake-utils_use_enable tk itk)
		$(cmake-utils_use_enable wxwidgets)
		$(cmake-utils_use threads PL_HAVE_PTHREAD)
		$(cmake-utils_use qhull PL_HAVE_QHULL)
		$(cmake-utils_use qt4 PLD_aqt)
		$(cmake-utils_use qt4 PLD_bmpqt)
		$(cmake-utils_use qt4 PLD_epsqt)
		$(cmake-utils_use qt4 PLD_extqt)
		$(cmake-utils_use qt4 PLD_jpgqt)
		$(cmake-utils_use qt4 PLD_memqt)
		$(cmake-utils_use qt4 PLD_pdfqt)
		$(cmake-utils_use qt4 PLD_pngqt)
		$(cmake-utils_use qt4 PLD_ppmqt)
		$(cmake-utils_use qt4 PLD_svgqt)
		$(cmake-utils_use qt4 PLD_qtwidget)
		$(cmake-utils_use qt4 PLD_tiffqt)
		$(cmake-utils_use cairo PLD_extcairo)
		$(cmake-utils_use cairo PLD_memcairo)
		$(cmake-utils_use cairo PLD_pdfcairo)
		$(cmake-utils_use cairo PLD_pngcairo)
		$(cmake-utils_use cairo PLD_pscairo)
		$(cmake-utils_use cairo PLD_svgcairo)
		$(cmake-utils_use cairo PLD_wincairo)
		$(cmake-utils_use cairo PLD_xcairo)
		$(cmake-utils_use tk PLD_ntk)
		$(cmake-utils_use tk PLD_tk)
		$(cmake-utils_use tk PLD_tkwin)
		$(cmake-utils_use gd PLD_gif)
		$(cmake-utils_use gd PLD_jpeg)
		$(cmake-utils_use gd PLD_png)
		$(cmake-utils_use pdf PLD_pdf)
		$(cmake-utils_use latex PLD_ps)
		$(cmake-utils_use latex PLD_pstex)
		$(cmake-utils_use truetype PLD_psttf)
		$(cmake-utils_use svg PLD_svg)
		$(cmake-utils_use wxwidgets PLD_wxpng)
		$(cmake-utils_use test PLD_ps)
		$(cmake-utils_use wxwidgets PLD_wxwidgets)
		$(cmake-utils_use X PLD_xwin)
	)

	[[ $(tc-getFC) != *g77 ]] && \
		mycmakeargs+=(
		$(cmake-utils_use_enable fortran f95)
	)

	use truetype && mycmakeargs+=(
		-DPL_FREETYPE_FONT_PATH:PATH="${EPREFIX}/usr/share/fonts/freefont-ttf"
	)

	use python && mycmakeargs+=( $(cmake-utils_use_enable qt4 pyqt4) )
	use doc && mycmakeargs+=( -DPREBUILT_DOC=ON )
	cmake-utils_src_configure

	# clean up bloated pkg-config files (help linking properly on prefix)
	sed -i \
		-e "/Cflags/s:-I\(${EPREFIX}\|\)/usr/include[[:space:]]::g" \
		-e "/Libs/s:-L\(${EPREFIX}\|\)/usr/lib\(64\|\)[[:space:]]::g" \
		-e "s:${LDFLAGS}::g" \
		"${CMAKE_BUILD_DIR}"/pkgcfg/*pc || die
}

src_test() {
	pushd "${CMAKE_BUILD_DIR}" > /dev/null
	Xemake test || die "tests failed"
	popd > /dev/null
}

src_install() {
	cmake-utils_src_install
	use examples || rm -rf "${ED}"/usr/share/doc/${PF}/examples
	if use java; then
		rm -rf "${ED}"/usr/share/java "${ED}"/usr/$(get_libdir)/jni
		java-pkg_dojar "${CMAKE_BUILD_DIR}"/examples/java/${PN}.jar
		java-pkg_doso "${CMAKE_BUILD_DIR}"/bindings/java/plplotjavac_wrap.so
	fi
}
