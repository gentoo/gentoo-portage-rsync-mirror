# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/oyranos/oyranos-0.9.4-r1.ebuild,v 1.5 2013/08/15 03:38:17 patrick Exp $

EAPI=5

inherit eutils flag-o-matic cmake-utils cmake-multilib

DESCRIPTION="colour management system allowing to share various settings across applications and services"
HOMEPAGE="http://www.oyranos.org/"
SRC_URI="mirror://sourceforge/oyranos/Oyranos/Oyranos%200.4/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X cairo cups doc exif fltk qt4 raw test"

RDEPEND="=app-admin/elektra-0.7*[${MULTILIB_USEDEP}]
	dev-libs/yajl[${MULTILIB_USEDEP}]
	media-libs/icc-profiles-basiccolor-printing2009
	media-libs/icc-profiles-basiccolor-printing2009
	>=media-libs/libXcm-0.5.2[${MULTILIB_USEDEP}]
	X? ( x11-libs/libXfixes[${MULTILIB_USEDEP}]
		x11-libs/libXrandr[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
		x11-libs/libXinerama[${MULTILIB_USEDEP}] )
	!amd64? (
		dev-libs/libxml2
		cairo? ( x11-libs/cairo )
		cups? ( net-print/cups )
		qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
		raw? ( media-libs/libraw )
		)
	amd64? (
		abi_x86_64? (
			dev-libs/libxml2
			|| ( media-libs/lcms:0 media-libs/lcms:2 )
			media-libs/libpng:0
			cairo? ( x11-libs/cairo )
			cups? ( net-print/cups )
			qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
			raw? ( media-libs/libraw )
		)
		abi_x86_32? (
			app-emulation/emul-linux-x86-baselibs
			cairo? ( app-emulation/emul-linux-x86-gtklibs )
			cups? ( app-emulation/emul-linux-x86-baselibs )
			qt4? ( app-emulation/emul-linux-x86-qtlibs )
		)
	)
	media-gfx/graphviz
	exif? ( media-gfx/exiv2 )
	fltk? ( x11-libs/fltk:1 )"
DEPEND="${RDEPEND}
	app-doc/doxygen"

RESTRICT="test"
REQUIRED_USE="amd64? ( exif? ( !abi_x86_32 )
	raw? ( !abi_x86_32 ) )"
CMAKE_REMOVE_MODULES_LIST="${CMAKE_REMOVE_MODULES_LIST} FindFltk FindXcm FindCUPS"

src_prepare() {
	einfo remove bundled libs
	rm -rf elektra* yajl || die

	epatch "${FILESDIR}/${P}"-buildsystem-r1.patch

	#upstream(ed) fixes, be more verbose, better xrandr handling
	epatch "${FILESDIR}/${P}"-fix-array-access.patch \
		"${FILESDIR}/${P}"-fix-oyRankMap-helper-functions-crashes.patch \
		"${FILESDIR}/${P}"-fix-oyStringSegment-crash.patch \
		"${FILESDIR}/${P}"-be-more-verbose.patch \
		"${FILESDIR}/${P}"-use-more-internal-xrandr-info.patch \
		"${FILESDIR}/${P}"-set-xcalib-to-screen-if-ge-xrandr-12.patch \
		"${FILESDIR}/${P}"-fix-double-object-release.patch \
		"${FILESDIR}/${P}"-omit-profile-with-error.patch \
		"${FILESDIR}/${P}"-fix-typos-and-grammar.patch

	#upstream fix for QA notice, gentoo bug 464254
	epatch "${FILESDIR}/${P}"-fix-runpaths.patch

	#fix really ugly and prominently visible typo (solved in 0.9.5)
	sed -e 's/Promt/Prompt/' \
		-i src/liboyranos_config/oyranos_texts.c po/*.{po,pot} settings/*xml || die

	if use fltk ; then
		#src/examples does not include fltk flags
		append-cflags $(fltk-config --cflags)
		append-cxxflags $(fltk-confiag --cxxflags)
	fi

	cmake-utils_src_prepare

	mycmakeargs=(
		$(usex X -DWANT_X11=1 "")
		$(usex cairo -DWANT_CAIRO=1 "")
		$(usex cups -DWANT_CUPS=1 "")
		$(usex exif -DWANT_EXIV2=1 "")
		$(usex fltk -DWANT_FLTK=1 "")
		$(usex qt4 -DWANT_QT4=1 "")
		$(usex raw -DWANT_LIBRAW=1 "")
	)
}

src_configure() {
	cmake-multilib_src_configure

	if use abi_x86_32 && use abi_x86_64 ; then
		sed -e 's:lib64:lib32:g' \
			-i "${S}"-x86/CMakeCache.txt || die
	fi
}

src_install() {
	if use abi_x86_32 && use abi_x86_64 ; then
		sed -e '/OY_LIBDIR/s:lib32:lib64:'\
			-i "${S}"-x86/src/include/oyranos_version.h || die
	fi

	cmake-multilib_src_install

	dodoc AUTHORS ChangeLog README
	if use doc ; then
		mv "${ED}/usr/share/doc/${PN}/*" "${ED}/usr/share/doc/${P}" || die
	fi
	rm -rf "${ED}/usr/share/doc/${PN}" || die
}
