# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-2.32.1-r1.ebuild,v 1.12 2012/12/16 09:10:31 tetromino Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 multilib

DESCRIPTION="CD/DVD burning application for the GNOME desktop"
HOMEPAGE="http://projects.gnome.org/brasero/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86"
IUSE="+cdr +css doc dvd +introspection +libburn nautilus playlist test vcd"

COMMON_DEPEND="
	>=dev-libs/glib-2.25.10:2
	media-libs/libcanberra[gtk]
	>=x11-libs/gtk+-2.21.9:2[introspection?]
	>=gnome-base/gconf-2.31.1:2
	>=media-libs/gstreamer-0.10.15:0.10
	>=media-libs/gst-plugins-base-0.10:0.10
	>=dev-libs/libxml2-2.6:2
	>=dev-libs/libunique-1:1
	x11-libs/libICE
	x11-libs/libSM
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	libburn? (
		>=dev-libs/libburn-0.4
		>=dev-libs/libisofs-0.6.4 )
	nautilus? ( >=gnome-base/nautilus-2.31.3 <gnome-base/nautilus-3 )
	playlist? ( >=dev-libs/totem-pl-parser-2.29.1 )"
RDEPEND="${COMMON_DEPEND}
	app-cdr/cdrdao
	app-cdr/dvd+rw-tools
	>=media-plugins/gst-plugins-meta-0.10-r6:0.10[dvd?,vcd?]
	x11-themes/hicolor-icon-theme
	css? ( media-libs/libdvdcss:1.2 )
	cdr? ( virtual/cdrtools )
	dvd? ( media-video/dvdauthor )
	vcd? ( media-video/vcdimager )
	!libburn? ( virtual/cdrtools )"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	virtual/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	gnome-base/gnome-common:3
	>=dev-util/gtk-doc-am-1.12
	test? ( app-text/docbook-xml-dtd:4.3 )"
# eautoreconf deps
#	gnome-base/gnome-common
PDEPEND="gnome-base/gvfs"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-silent-rules
		--disable-scrollkeeper
		--disable-caches
		--disable-dependency-tracking
		--with-gtk=2.0
		--disable-search
		$(use_enable cdr cdrtools)
		$(use_enable cdr cdrkit)
		$(use_enable introspection)
		$(use_enable libburn libburnia)
		$(use_enable nautilus)
		$(use_enable playlist)"

	if ! use libburn; then
		G2CONF="${G2CONF} --enable-cdrtools --enable-cdrkit"
	fi

	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlinking.patch

	# Fix link against installed libraries, bug #340767
	epatch "${FILESDIR}/${PN}-2.32.0-build-plugins-against-local-library.patch"

	# Silenced some warnings
	epatch "${FILESDIR}/${P}-warning-silenced.patch"
	epatch "${FILESDIR}/${P}-warning-silenced2.patch"

	# Make sure that the size is displayed correctly when burning tracks internally copied with cdda2wav
	epatch "${FILESDIR}/${P}-fix-size.patch"

	# Do not show useless dialog warning about the nature of the medium when we are copying audio from a CDRW
	epatch "${FILESDIR}/${P}-useless-dialog.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

pkg_preinst() {
	gnome2_pkg_preinst

	preserve_old_lib /usr/$(get_libdir)/libbrasero-burn.so.0
	preserve_old_lib /usr/$(get_libdir)/libbrasero-media.so.0
	preserve_old_lib /usr/$(get_libdir)/libbrasero-utils.so.0
}

pkg_postinst() {
	gnome2_pkg_postinst

	preserve_old_lib_notify /usr/$(get_libdir)/libbrasero-burn.so.0
	preserve_old_lib_notify /usr/$(get_libdir)/libbrasero-media.so.0
	preserve_old_lib_notify /usr/$(get_libdir)/libbrasero-utils.so.0

	echo
	elog "If ${PN} doesn't handle some music or video format, please check"
	elog "your USE flags on media-plugins/gst-plugins-meta:0.10"
}
