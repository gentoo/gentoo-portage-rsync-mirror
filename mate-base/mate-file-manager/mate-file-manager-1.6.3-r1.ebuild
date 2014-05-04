# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-base/mate-file-manager/mate-file-manager-1.6.3-r1.ebuild,v 1.2 2014/05/04 14:53:51 ago Exp $

EAPI="5"

GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2 versionator virtualx

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Caja file manager for the MATE desktop"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64"

IUSE="X +mate +introspection +unique xmp"

RDEPEND="dev-libs/atk:0
	>=dev-libs/glib-2.28:2
	>=dev-libs/libxml2-2.4.7:2
	|| (
		>=gnome-base/gvfs-1.10.1:0[gdu]
		>=gnome-base/gvfs-1.10.1:0[udisks]
	)
	>=mate-base/mate-desktop-1.6:0
	>=media-libs/libexif-0.5.12:0
	>=x11-libs/gtk+-2.24:2[introspection?]
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/libICE:0
	x11-libs/libSM:0
	x11-libs/libX11:0
	x11-libs/libXext:0
	x11-libs/libXft:0
	x11-libs/libXrender:0
	>=x11-libs/pango-1.1.2:0
	virtual/libintl:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.4:0 )
	unique? ( >=dev-libs/libunique-1:1 )
	xmp? ( >=media-libs/exempi-1.99.2:2 )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5:0=
	dev-util/gdbus-codegen:0
	>=dev-util/intltool-0.40.1:*
	>=mate-base/mate-common-1.6:0
	sys-devel/gettext:*
	virtual/pkgconfig:*"

PDEPEND="mate? ( >=x11-themes/mate-icon-theme-1.6:0 )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-r1-fix-x-caja-desktop-multiple-windows-issue.patch

	gnome2_src_prepare

	# Remove -n parameter.
	sed -i -e 's:Exec=caja -n:Exec=caja:g' \
		data/caja.desktop || die

	# Remove crazy CFLAGS.
	sed -i -e 's:-DG.*DISABLE_DEPRECATED::g' \
		configure{,.ac} eel/Makefile.{am,in} || die
}

src_configure() {
	gnome2_src_configure \
		--enable-unique \
		--disable-packagekit \
		--disable-update-mimedb \
		--with-gtk=2.0 \
		$(use_enable introspection) \
		$(use_enable unique) \
		$(use_enable xmp) \
		$(use_with X x)
}

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README THANKS TODO"

src_test() {
	unset SESSION_MANAGER
	unset DBUS_SESSION_BUS_ADDRESS

	Xemake check || die "Test phase failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "caja can use gstreamer to preview audio files. Just make sure"
	elog "to have the necessary plugins available to play the media type you"
	elog "want to preview."
}
