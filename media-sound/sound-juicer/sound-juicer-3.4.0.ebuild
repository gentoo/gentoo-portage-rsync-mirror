# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sound-juicer/sound-juicer-3.4.0.ebuild,v 1.8 2013/02/02 22:58:39 ago Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="CD ripper for GNOME"
HOMEPAGE="http://www.burtonini.com/blog/computers/sound-juicer/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.90:3
	media-libs/libcanberra[gtk3]
	>=app-cdr/brasero-2.90
	>=gnome-base/gconf-2:2
	sys-apps/dbus

	media-libs/libdiscid
	media-libs/musicbrainz:4

	>=media-libs/gstreamer-0.10.32:0.10
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
		--disable-scrollkeeper
		GST_INSPECT=$(type -P true)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn "If ${PN} does not rip to some music format, please check your USE flags"
	ewarn "on media-libs/libgnome-media-profiles and media-plugins/gst-plugins-meta"
	ewarn
	ewarn "The list of audio encoding profiles in ${P} is non-customizable."
	ewarn "A possible workaround is to rip to flac using ${PN}, and convert to"
	ewarn "your desired format using a separate tool."
}
