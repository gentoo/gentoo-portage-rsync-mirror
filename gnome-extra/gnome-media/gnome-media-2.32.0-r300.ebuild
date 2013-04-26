# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-media/gnome-media-2.32.0-r300.ebuild,v 1.6 2013/04/26 06:31:44 patrick Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Multimedia related programs for the GNOME desktop"
HOMEPAGE="http://ronald.bitfreak.net/gnome-media.php"

LICENSE="LGPL-2 GPL-2 FDL-1.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

# NOTE: This package provides the following:
#  * libgnome-media-profiles.so.0
#  * gstreamer-properties
#  * gnome-sound-recorder
#  * gnome-audio-profiles
# NOTE: It has /stopped/ providing the following:
#  * gnome-volume-control (moved to gnome-control-center)
#  * gstmixer (won't work under GNOME 3, even in classic-gnome)
#  * gnome-audio-profile-properties (moved to libgnome-media-profiles)
RDEPEND="dev-libs/libxml2:2
	>=dev-libs/glib-2.18.2:2
	>=x11-libs/gtk+-2.18.0:2
	>=gnome-base/gconf-2.6.1:2
	>=media-libs/gstreamer-0.10.23:0.10
	>=media-libs/gst-plugins-base-0.10.23:0.10
	>=media-libs/gst-plugins-good-0.10:0.10
	>=media-libs/libcanberra-0.13[gtk]
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	>=media-plugins/gst-plugins-gconf-0.10.1:0.10
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	app-text/rarian
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35.0
	gnome-base/gnome-common" # required by eautoreconf wrt #408281

src_prepare() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-scrollkeeper
		--disable-schemas-install
		--enable-gstprops
		--enable-grecord
		--enable-profiles
		--disable-pulseaudio
		--disable-gstmix"
	DOCS="AUTHORS ChangeLog* NEWS MAINTAINERS README"

	# This has been moved to media-libs/libgnome-media-profiles:3,
	# but the library libgnome-media-profiles.so.0 is still used
	epatch "${FILESDIR}/${P}-disable-gnome-audio-profile-properties.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
        sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.ac || die
	eautoreconf
}

src_install() {
	gnome2_src_install

	# These files are now provided by gnome-control-center-2.91's sound applet
	# These won't be used if gnome-volume-control is not installed
	rm -v "${ED}"/usr/share/sounds/gnome/default/alerts/*.ogg || die
}

pkg_postinst() {
	gnome2_pkg_postinst
	ewarn
	ewarn "If you cannot play some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta:0.10"
	ewarn
}
