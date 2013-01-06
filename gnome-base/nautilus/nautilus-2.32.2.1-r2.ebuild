# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.32.2.1-r2.ebuild,v 1.9 2012/12/20 16:27:56 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2 virtualx

DESCRIPTION="A file manager for the GNOME desktop"
HOMEPAGE="http://live.gnome.org/Nautilus"

SRC_URI="${SRC_URI} http://dev.gentoo.org/~pacho/gnome/${P}-patches.tar.bz2"

LICENSE="GPL-2+ LGPL-2+ FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE="gnome +introspection xmp"

RDEPEND=">=dev-libs/glib-2.28.0:2
	>=gnome-base/gnome-desktop-2.29.91:2
	>=x11-libs/pango-1.1.2
	>=x11-libs/gtk+-2.22:2[introspection?]
	>=dev-libs/libxml2-2.4.7:2
	>=media-libs/libexif-0.5.12
	>=gnome-base/gconf-2:2
	dev-libs/libunique:1
	gnome-base/dconf
	x11-libs/libXext
	x11-libs/libXrender
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	xmp? ( media-libs/exempi:2 )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sys-devel/gettext
	virtual/pkgconfig
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.40.1"
# For eautoreconf
#	gnome-base/gnome-common

PDEPEND="gnome? ( >=x11-themes/gnome-icon-theme-1.1.91 )
	>=gnome-base/gvfs-0.1.2"

src_prepare() {
	G2CONF="${G2CONF}
		--disable-update-mimedb
		--disable-packagekit
		$(use_enable introspection)
		$(use_enable xmp)"
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README THANKS TODO"

	# Apply multiple upstream fixes
	epatch "${WORKDIR}/${P}-patches"/*.patch

	# build failure with ld.gold, fixed in 3.4
	epatch "${FILESDIR}/${P}-gold-glib2.32.patch"
	eautoreconf

	gnome2_src_prepare
}

src_test() {
	addpredict "/root/.gnome2_private"
	unset SESSION_MANAGER
	unset ORBIT_SOCKETDIR
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "Test phase failed"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "nautilus can use gstreamer to preview audio files. Just make sure"
	elog "to have the necessary plugins available to play the media type you"
	elog "want to preview"
}
