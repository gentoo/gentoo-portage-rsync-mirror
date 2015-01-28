# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-9999.ebuild,v 1.11 2015/01/28 08:49:52 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="tk?"

inherit cmake-utils fdo-mime flag-o-matic multilib python-single-r1 subversion

DESCRIPTION="Desktop publishing (DTP) and layout program"
HOMEPAGE="http://www.scribus.net/"
SRC_URI=""
ESVN_REPO_URI="svn://scribus.net/trunk/Scribus"
ESVN_PROJECT=Scribus-1.5

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cairo debug examples graphicsmagick hunspell +minimal osg +pdf poppler scripts templates tk"

# a=$(ls resources/translations/po/scribus.*ts | sed -e 's:\.: :g' | awk '{print $2}'); echo ${a}
IUSE_LINGUAS=" af ar bg br ca cs_CZ cy da_DK de de_1901 de_CH el en_AU en_GB en_US es_ES et eu fi fr gl hu id it ja ko lt_LT nb_NO nl pl_PL pt pt_BR ru sa sk_SK sl sq sr sv th_TH tr uk zh_CN zh_TW"
IUSE+=" ${IUSE_LINGUAS// / linguas_}"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	tk? ( scripts )"

# osg
# couple of third_party libs bundled
COMMON_DEPEND="
	${PYTHON_DEPS}
	app-text/libmspub
	dev-libs/boost
	dev-libs/hyphen
	dev-libs/librevenge
	dev-libs/libxml2
	dev-qt/linguist:5
	dev-qt/linguist-tools:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtwebkit:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/lcms:2
	media-libs/libcdr
	media-libs/libpagemaker
	media-libs/libpng:0
	media-libs/libvisio
	media-libs/tiff:0
	net-print/cups
	sys-libs/zlib[minizip]
	virtual/jpeg
	cairo? ( >=x11-libs/cairo-1.10.0[X,svg] )
	!cairo? ( media-libs/libart_lgpl )
	hunspell? ( app-text/hunspell )
	graphicsmagick? ( media-gfx/graphicsmagick )
	osg? ( dev-games/openscenegraph )
	pdf? ( app-text/podofo )
	poppler? ( >=app-text/poppler-0.19.0 )
	scripts? ( virtual/python-imaging[tk?,${PYTHON_USEDEP}] )
	tk? ( virtual/python-imaging[tk?,${PYTHON_USEDEP}] )
"
RDEPEND="${COMMON_DEPEND}
	app-text/ghostscript-gpl"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${PN}-1.5.0-docs.patch
	)

src_prepare() {
	rm -r codegen/cheetah || die
	cat > cmake/modules/FindZLIB.cmake <<- EOF
	find_package(PkgConfig)
	pkg_check_modules(ZLIB minizip zlib)
	SET( ZLIB_LIBRARY \${ZLIB_LIBRARIES} )
	SET( ZLIB_INCLUDE_DIR \${ZLIB_INCLUDE_DIRS} )
	MARK_AS_ADVANCED( ZLIB_LIBRARY ZLIB_INCLUDE_DIR )
	EOF

	sed \
		-e "/^\s*unzip\.[ch]/d" \
		-e "/^\s*ioapi\.[ch]/d" \
		-i scribus/CMakeLists.txt || die

	sed \
		-e 's:\(${CMAKE_INSTALL_PREFIX}\):./\1:g' \
		-i resources/templates/CMakeLists.txt || die

	use amd64 && append-flags -fPIC

	cmake-utils_src_prepare
	subversion_src_prepare
}

src_configure() {
	local lang langs
	for lang in ${IUSE_LINGUAS}; do
		if use linguas_${lang}; then
			langs+=",${lang}"
		else
			sed -e "/${lang}/d" -i doc/CMakeLists.txt || die
		fi
	done

	local mycmakeargs=(
		-DHAVE_PYTHON=ON
		-DPYTHON_INCLUDE_PATH="$(python_get_includedir)"
		-DPYTHON_LIBRARY="$(python_get_library_path)"
		-DWANT_NORPATH=ON
		-DWANT_QTARTHUR=ON
		-DWANT_QT3SUPPORT=OFF
		-DGENTOOVERSION=${PVR}
		-DWANT_GUI_LANG=${langs#,}
		$(cmake-utils_use_with pdf PODOFO)
		$(cmake-utils_use_want cairo)
		$(cmake-utils_use_want graphicsmagick)
		$(cmake-utils_use_want osg)
		$(cmake-utils_use_want debug DEBUG)
		$(cmake-utils_use_want minimal NOHEADERINSTALL)
		$(cmake-utils_use_want hunspell HUNSPELL)
		$(cmake-utils_use_want !examples NOEXAMPLES)
		$(cmake-utils_use_want !templates NOTEMPLATES)
		)
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

	if ! use scripts; then
		rm "${ED}"/usr/share/scribus/scripts/*.py || die
	elif ! use tk; then
		rm "${ED}"/usr/share/scribus/scripts/{FontSample,CalendarWizard}.py || die
	fi

	use scripts && python_fix_shebang "${ED}"/usr/share/scribus/scripts
	use scripts && python_optimize "${ED}"/usr/share/scribus/scripts

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
