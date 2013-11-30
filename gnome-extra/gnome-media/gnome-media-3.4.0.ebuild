# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-3.4.0.ebuild,v 1.3 2013/11/30 19:20:13 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="LGPL-2 GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="amd64 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

# NOTE: This package provides the following:
#  * libgnome-media-profiles.so.0
#  * gstreamer-properties
#  * gnome-sound-recorder
#  * gnome-audio-profiles
RDEPEND="
	dev-libs/libxml2:2
	>=dev-libs/glib-2.18.2:2
	>=x11-libs/gtk+-2.91:3
	>=gnome-base/gconf-2.6.1:2
	>=media-libs/gstreamer-0.10.23:0.10
	>=media-libs/gst-plugins-base-0.10.23:0.10
	>=media-libs/gst-plugins-good-0.10:0.10
	>=media-libs/libcanberra-0.13[gtk3]
	media-libs/libgnome-media-profiles:3
	>=media-plugins/gst-plugins-gconf-0.10.1:0.10
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/gnome-doc-utils-0.3.2
	app-text/rarian
	>=dev-util/intltool-0.35.0
	gnome-base/gnome-common
	virtual/pkgconfig
"

src_configure() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-schemas-install
		--enable-gstprops
		--enable-grecord
		--disable-gstmix
	"
	DOCS="AUTHORS ChangeLog* NEWS MAINTAINERS README"

	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	# These files are now provided by gnome-control-center-2.91's sound applet
	# These won't be used if gnome-volume-control is not installed
	rm -v "${ED}"/usr/share/gnome-media/sounds/gnome-sounds-default.xml
	rm -v "${ED}"/usr/share/sounds/gnome/default/alerts/*.ogg || die
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn
	ewarn "If you cannot play some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta:0.10"
	ewarn
}
