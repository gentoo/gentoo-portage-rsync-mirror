# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.9.4.1.ebuild,v 1.3 2012/09/05 09:36:33 jlec Exp $

EAPI="4"
PYTHON_DEPEND="2:2.6"
WX_GTK_VER="2.9"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython 2.7-pypy-*"

inherit alternatives distutils eutils fdo-mime wxwidgets

MY_PN="wxPython-src"

DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_PN}-2.9.4.0.tar.bz2
	examples? ( mirror://sourceforge/wxpython/wxPython-demo-2.9.4.0.tar.bz2 )
	mirror://sourceforge/wxpython/${MY_PN}-2.9.4.1.patch"

LICENSE="wxWinLL-3"
SLOT="2.9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cairo examples opengl"

RDEPEND="
	>=x11-libs/wxGTK-${PV}:${WX_GTK_VER}[opengl?,tiff,X]
	dev-libs/glib:2
	dev-python/setuptools
	media-libs/libpng:0
	media-libs/tiff:0
	virtual/jpeg
	x11-libs/gtk+:2
	x11-libs/pango[X]
	cairo?	( >=dev-python/pycairo-1.8.4 )
	opengl?	( dev-python/pyopengl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-2.9.4.0/wxPython"
DOC_S="${WORKDIR}/wxPython-2.9.4.0"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
PYTHON_CXXFLAGS=("2.* + -fno-strict-aliasing")

PYTHON_MODNAME="wx-${PV%.*}-gtk2 wxversion.py"

src_prepare() {
	sed -i "s:cflags.append('-O3'):pass:" config.py || die "sed failed"

	cd ..
	epatch "${DISTDIR}"/${MY_PN}-${PV}.patch
	cd "${S}"
	epatch "${FILESDIR}"/${P}-wxversion-scripts.patch
	# drop editra - we have it as a separate package now
	epatch "${FILESDIR}"/${PN}-2.8.11-drop-editra.patch

	if use examples; then
		cd "${DOC_S}"
		epatch "${FILESDIR}"/${PN}-${SLOT}-wxversion-demo.patch
	fi

	python_copy_sources
}

src_configure() {
	need-wxwidgets unicode

	DISTUTILS_GLOBAL_OPTIONS=(
		"* WX_CONFIG=${WX_CONFIG}"
		"* WXPORT=gtk2"
		"* UNICODE=1"
		"* BUILD_GLCANVAS=$(use opengl && echo 1 || echo 0)"
	)
}

distutils_src_install_post_hook() {
	# Collision protection.
	local file
	for file in "$(distutils_get_intermediate_installation_image)${EPREFIX}"/usr/bin/*; do
		mv "${file}" "${file}-${SLOT}"
	done
}

src_install() {
	distutils_src_install

	local file x
	# Collision protection.
	rename_files() {
		for file in "${D}$(python_get_sitedir)/"wx{version.*,.pth}; do
			mv "${file}" "${file}-${SLOT}" || return 1
		done
	}
	python_execute_function -q rename_files

	dodoc "${S}"/docs/{CHANGES,PyManual,README,wxPackage,wxPythonManual}.txt

	for x in {Py{AlaMode,Crust,Shell},XRCed}; do
		newmenu "${S}"/distrib/${x}.desktop ${x}-${SLOT}.desktop
	done
	newicon "${S}"/wx/py/PyCrust_32.png PyCrust-${SLOT}.png
	newicon "${S}"/wx/py/PySlices_32.png PySlices-${SLOT}.png
	newicon "${S}"/wx/tools/XRCed/XRCed_32.png XRCed-${SLOT}.png

	if use examples; then
		dodir /usr/share/doc/${PF}/demo
		dodir /usr/share/doc/${PF}/samples
		cp -R "${DOC_S}"/demo/* "${D}"/usr/share/doc/${PF}/demo/ || die
		cp -R "${DOC_S}"/samples/* "${D}"/usr/share/doc/${PF}/samples/ || die
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	create_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym "$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_execute_function -q create_symlinks

	distutils_pkg_postinst

	echo
	elog "Gentoo uses the Multi-version method for SLOT'ing."
	elog "Developers, see this site for instructions on using"
	elog "2.8 or 2.9 with your apps:"
	elog "http://wiki.wxpython.org/index.cgi/MultiVersionInstalls"
	elog
	if use examples; then
		elog "The demo.py app which contains demo modules with"
		elog "documentation and source code has been installed at"
		elog "/usr/share/doc/${PF}/demo/demo.py"
		elog
		elog "More example apps and modules can be found in"
		elog "/usr/share/doc/${PF}/samples/"
	fi
	echo
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update

	create_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym "$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_execute_function -q create_symlinks
}
