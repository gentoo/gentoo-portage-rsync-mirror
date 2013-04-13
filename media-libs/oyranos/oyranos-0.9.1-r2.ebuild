# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/oyranos/oyranos-0.9.1-r2.ebuild,v 1.3 2013/04/13 02:23:48 xmw Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="colour management system allowing to share various settings across applications and services"
HOMEPAGE="http://www.oyranos.org/"
SRC_URI="mirror://sourceforge/oyranos/Oyranos/Oyranos%200.4/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X doc fltk static-libs test xinerama"

RDEPEND="=app-admin/elektra-0.7.1-r3
	dev-libs/libxml2
	dev-libs/yajl
	media-gfx/exiv2
	media-libs/icc-profiles-basiccolor-printing2009
	media-libs/icc-profiles-openicc
	media-libs/lcms:0
	media-libs/libpng:0
	media-libs/libraw
	>=media-libs/libXcm-0.5.1
	fltk? ( x11-libs/fltk:1 )
	X? ( x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXxf86vm
		xinerama? ( x11-libs/libXinerama ) )"
DEPEND="${RDEPEND}
	app-doc/doxygen
	media-gfx/graphviz"

RESTRICT="test"
REQUIRED_USE="fltk? ( X )"

src_prepare() {
	einfo remove bundled elektra yajl
	rm -rf elektra* yajl || die
	#keep bundled libXNVCtrl

	epatch \
		"${FILESDIR}"/${PN}-0.9.0-buildsystem.patch \
		"${FILESDIR}"/${P}-buildsystem-2.patch \
		"${FILESDIR}"/${P}-fix-real-compiler-warnings.patch \
		"${FILESDIR}"/${P}-fix-more-compiler-warnings.patch \
		"${FILESDIR}"/${P}-support-pur-xrandr-without-xinerama.patch \
		"${FILESDIR}"/${P}-fix-pseq-crash.patch \
		"${FILESDIR}"/${P}-fix-oyStringSegment-crash.patch \
		"${FILESDIR}"/${P}-fix-crash-over-missed-output-image.patch \
		"${FILESDIR}"/${P}-fix-oyRankMap-helper-functions-crashes.patch \
		"${FILESDIR}"/${P}-initialise-memory-for-strtod.patch \
		"${FILESDIR}"/${P}-fix-double-object-release.patch \
		"${FILESDIR}"/${P}-fix-array-access.patch \
		"${FILESDIR}"/${P}-omit-profile-with-error.patch

	#fix typos
	sed -e '/^ */s:triffers:triggers:' -i API_generated/*c || die
	sed -e 's/Promt/Prompt/' -i oyranos_texts.c po/*.{po,pot} settings/*xml || die

	if ! use fltk ; then
		sed -e '/FLTK_GUI =/s:=.*:=:' \
			-i makefile.in || die
		sed -e '/all:/s:oyranos-xforms-fltk::' \
			-i oforms/oyranos_xforms.makefile || die
	fi
}

src_configure() {
	tc-export CC CXX
	econf --prefix=/usr \
		--enable-verbose \
		$(use_with X x) \
		$(use_enable X libX11) \
		$(use_enable X libXext) \
		$(use_enable X libXrandr) \
		$(use_enable X libXxf86vm) \
		$(use_enable fltk fltk) \
		$(use_enable static-libs static) \
		$(use_enable xinerama libXinerama)
}

src_compile() {
	emake all
	use X && emake oforms
	emake docu
}

src_install() {
	emake DESTDIR="${D}" docdir="${EPREFIX}"/usr/share/doc/${P} install-main

	if ! use doc ; then
		rm -rf "${ED}/usr/share/doc/${P}/html" || die
	fi
}
