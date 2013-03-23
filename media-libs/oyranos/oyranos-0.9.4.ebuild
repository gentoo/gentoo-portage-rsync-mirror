# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/oyranos/oyranos-0.9.4.ebuild,v 1.1 2013/03/23 18:17:07 xmw Exp $

EAPI=5

inherit eutils flag-o-matic cmake-utils cmake-multilib

DESCRIPTION="colour management system allowing to share various settings across applications and services"
HOMEPAGE="http://www.oyranos.org/"
SRC_URI="mirror://sourceforge/oyranos/Oyranos/Oyranos%200.4/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X cairo cups doc exif fltk qt4 raw test"

RDEPEND=">=app-admin/elektra-0.8.3-r1
	dev-libs/libxml2
	dev-libs/yajl
	media-gfx/exiv2
	|| ( media-libs/lcms:0 media-libs/lcms:2 )
	media-libs/libpng:0
	media-libs/libraw
	>=media-libs/libXcm-0.5.1
	fltk? ( x11-libs/fltk:1 )
	X? ( x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXxf86vm
		x11-libs/libXinerama )
	cairo? ( x11-libs/cairo )
	cups? (	net-print/cups )
	exif? ( media-gfx/exiv2 )
	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
	raw? ( media-libs/libraw )"
DEPEND="${RDEPEND}
	app-doc/doxygen
	media-gfx/graphviz
	test? ( media-libs/icc-profiles-basiccolor-printing2009
		media-libs/icc-profiles-openicc )"

#RESTRICT="test"

CMAKE_REMOVE_MODULES_LIST="${CMAKE_REMOVE_MODULES_LIST} FindFltk FindElektra FindXcm FindCUPS"

src_prepare() {
	epatch "${FILESDIR}/${P}"-buildsystem.patch

	if use fltk ; then
		#src/examples does not include fltk flags
		append-cflags $(fltk-config --cflags)
		append-cxxflags $(fltk-confiag --cxxflags)
	fi

	cmake-utils_src_prepare

	einfo remove bundled libs
	rm -rf elektra* yajl || die

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

src_install() {
	cmake-multilib_src_install

	dodoc AUTHORS ChangeLog README
	if use doc ; then
		mv "${ED}/usr/share/doc/${PN}/*" "${ED}/usr/share/doc/${P}" || die
	fi
	rm -rf "${ED}/usr/share/doc/${PN}" || die
}
