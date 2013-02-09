# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/darktable/darktable-1.1.3.ebuild,v 1.2 2013/02/09 22:28:59 radhermit Exp $

EAPI="5"

inherit cmake-utils toolchain-funcs gnome2-utils fdo-mime pax-utils eutils

DESCRIPTION="A virtual lighttable and darkroom for photographers"
HOMEPAGE="http://www.darktable.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz
	doc? ( mirror://sourceforge/${PN}/${PN}-usermanual-1.1.2.pdf )"

LICENSE="GPL-3 CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="colord doc facebook flickr geo gnome-keyring gphoto2 kde
nls opencl openmp pax_kernel +rawspeed +slideshow"

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.28:2
	dev-libs/libxml2:2
	colord? ( x11-misc/colord )
	facebook? ( dev-libs/json-glib )
	flickr? ( media-libs/flickcurl )
	geo? ( net-libs/libsoup:2.4 )
	gnome-keyring? ( gnome-base/gnome-keyring )
	gnome-base/librsvg:2
	gphoto2? ( media-libs/libgphoto2 )
	kde? (
		dev-libs/dbus-glib
		kde-base/kwalletd
	)
	media-gfx/exiv2[xmp]
	media-libs/lcms:2
	>=media-libs/lensfun-0.2.3
	media-libs/libpng:0
	media-libs/openexr
	media-libs/tiff:0
	net-misc/curl
	opencl? ( virtual/opencl )
	slideshow? (
		media-libs/libsdl
		virtual/glu
		virtual/opengl
	)
	virtual/jpeg
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_pretend() {
	if use openmp ; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	sed -e "s:\(/share/doc/\)darktable:\1${PF}:" \
		-e "s:LICENSE::" \
		-i doc/CMakeLists.txt || die

	epatch_user
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use colord COLORD)
		$(cmake-utils_use_use facebook GLIBJSON)
		$(cmake-utils_use_use flickr FLICKR)
		$(cmake-utils_use_use geo GEO)
		$(cmake-utils_use_use gnome-keyring GNOME_KEYRING)
		$(cmake-utils_use_use gphoto2 CAMERA_SUPPORT)
		$(cmake-utils_use_use kde KWALLET)
		$(cmake-utils_use_use nls NLS)
		$(cmake-utils_use_use opencl OPENCL)
		$(cmake-utils_use_use openmp OPENMP)
		$(cmake-utils_use !rawspeed DONT_USE_RAWSPEED)
		$(cmake-utils_use_build slideshow SLIDESHOW)
		-DCUSTOM_CFLAGS=ON
		-DINSTALL_IOP_EXPERIMENTAL=ON
		-DINSTALL_IOP_LEGACY=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use doc && dodoc "${DISTDIR}"/${PN}-usermanual-1.1.2.pdf

	if use pax_kernel && use opencl ; then
		pax-mark Cm "${ED}"/usr/bin/${PN} || die
		eqawarn "USE=pax_kernel is set meaning that ${PN} will be run"
		eqawarn "under a PaX enabled kernel. To do so, the ${PN} binary"
		eqawarn "must be modified and this *may* lead to breakage! If"
		eqawarn "you suspect that ${PN} is broken by this modification,"
		eqawarn "please open a bug."
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
