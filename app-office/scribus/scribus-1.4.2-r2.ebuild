# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.4.2-r2.ebuild,v 1.2 2013/02/07 12:55:18 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE=tk

inherit cmake-utils fdo-mime multilib python-single-r1

DESCRIPTION="Desktop publishing (DTP) and layout program"
HOMEPAGE="http://www.scribus.net/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="aspell cairo debug examples hunspell +minimal +pdf templates"

# a=$(ls resources/translations/po/scribus.*ts | sed -e 's:\.: :g' | awk '{print $2}'); echo ${a}
IUSE_LINGUAS=" af ar bg br ca cs_CZ cy da_DK de de_1901 de_CH el en_AU en_GB en_US es_ES et eu fi fr gl hu id it ja ko lt_LT nb_NO nl pl_PL pt pt_BR ru sa sk_SK sl sq sr sv th_TH tr uk zh_CN zh_TW"
IUSE+=" ${IUSE_LINGUAS// / linguas_}"

COMMON_DEPEND="
	dev-python/imaging[tk,${PYTHON_USEDEP}]
	dev-libs/boost
	dev-libs/hyphen
	dev-libs/libxml2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	media-libs/libpng:0
	media-libs/tiff:0
	net-print/cups
	sys-libs/zlib[minizip]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	virtual/jpeg
	cairo? ( x11-libs/cairo[X,svg] )
	pdf? ( app-text/podofo )
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell )"
RDEPEND="${COMMON_DEPEND}
	app-text/ghostscript-gpl"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-docs.patch
	"${FILESDIR}"/${PN}-1.4.0-minizip.patch
	)

src_prepare() {
	cat > cmake/modules/FindZLIB.cmake <<- EOF
	find_package(PkgConfig)
	pkg_check_modules(ZLIB minizip zlib)
	SET( ZLIB_LIBRARY \${ZLIB_LIBRARIES} )
	SET( ZLIB_INCLUDE_DIR \${ZLIB_INCLUDE_DIRS} )
	MARK_AS_ADVANCED( ZLIB_LIBRARY ZLIB_INCLUDE_DIR )
	EOF

	rm scribus/{ioapi,unzip}.[ch] || die

	sed \
		-e 's:\(${CMAKE_INSTALL_PREFIX}\):./\1:g' \
		-i resources/templates/CMakeLists.txt || die

	base_src_prepare
}

src_configure() {
	local lang langs
	for lang in ${IUSE_LINGUAS}; do
		if use linguas_${lang}; then
			langs+=",${lang}"
		else
			sed -e "/${lang}/d" -i scribus/doc/CMakeLists.txt || die
		fi
	done

	local mycmakeargs=(
		-DHAVE_PYTHON=ON
		-DPYTHON_INCLUDE_PATH=$(python_get_includedir)
		-DPYTHON_LIBRARY="${EPREFIX}/usr/$(get_libdir)/lib${EPYTHON}.so"
		-DWANT_NORPATH=ON
		-DWANT_QTARTHUR=ON
		-DWANT_QT3SUPPORT=OFF
		-DGENTOOVERSION=${PVR}
		-DWANT_GUI_LANG=${langs#,}
		$(cmake-utils_use_with aspell ASPELL)
		$(cmake-utils_use_with pdf PODOFO)
		$(cmake-utils_use_want cairo)
		$(cmake-utils_use_want debug DEBUG)
		$(cmake-utils_use_want minimal NOHEADERINSTALL)
		$(cmake-utils_use_want hunspell HUNSPELL)
		)
	use examples || mycmakeargs+=( -DWANT_NOEXAMPLES=ON)
	use templates || mycmakeargs+=( -DWANT_NOTEMPLATES=ON)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	local lang file
	for lang in ${IUSE_LINGUAS}; do
		file="${ED}"/usr/share/scribus/translations/scribus.${lang}.qm
		if ! use linguas_${lang} && [[ -f "${file}" ]]; then
			rm "${file}" || die
		fi
	done

	mv "${ED}"/usr/share/doc/${PF}/{en,html} || die
	ln -sf html "${ED}"/usr/share/doc/${PF}/en || die
	docompress -x /usr/share/doc/${PF}/en
	doicon resources/icons/scribus.png
	domenu scribus.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
