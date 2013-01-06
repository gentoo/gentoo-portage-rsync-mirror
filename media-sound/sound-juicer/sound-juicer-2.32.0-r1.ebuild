# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-2.32.0-r1.ebuild,v 1.9 2012/05/05 08:53:59 mgorny Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="CD ripper for GNOME"
HOMEPAGE="http://www.burtonini.com/blog/computers/sound-juicer/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.20:2
	media-libs/libcanberra[gtk]
	>=app-cdr/brasero-2.26
	<app-cdr/brasero-3
	gnome-base/gconf:2
	sys-apps/dbus
	dev-libs/dbus-glib

	>=media-libs/musicbrainz-3.0.2:3
	>=gnome-extra/gnome-media-2.11.91
	<gnome-extra/gnome-media-2.91

	>=media-libs/gstreamer-0.10.15:0.10
	>=media-libs/gst-plugins-base-0.10:0.10"

RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs[cdda,udev]
	>=media-plugins/gst-plugins-gconf-0.10:0.10
	>=media-plugins/gst-plugins-gio-0.10:0.10
	|| (
		>=media-plugins/gst-plugins-cdparanoia-0.10:0.10
		>=media-plugins/gst-plugins-cdio-0.10:0.10 )
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10"

DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=app-text/scrollkeeper-0.3.5
	app-text/gnome-doc-utils
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

pkg_setup() {
	# GST_INSPECT needed to get around some sandboxing checks
	G2CONF="${G2CONF}
		--with-gtk=2.0
		--disable-scrollkeeper GST_INSPECT=/bin/true"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	gnome2_src_prepare

	# Fix description in desktop file, bug #377855
	epatch "${FILESDIR}"/${P}-desktop-file.patch
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn "If ${PN} does not rip to some music format, please check your USE"
	ewarn "flags on gnome-extra/gnome-media and media-plugins/gst-plugins-meta"
}
