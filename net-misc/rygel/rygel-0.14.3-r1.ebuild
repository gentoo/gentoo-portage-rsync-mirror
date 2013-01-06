# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rygel/rygel-0.14.3-r1.ebuild,v 1.2 2012/10/25 20:57:50 eva Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Rygel is an open source UPnP/DLNA MediaServer"
HOMEPAGE="http://live.gnome.org/Rygel"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X nls +sqlite tracker test transcode"

# The deps for tracker? and transcode? are just the earliest available
# version at the time of writing this ebuild
RDEPEND="
	>=dev-libs/glib-2.26:2
	>=dev-libs/libgee-0.5.2:0
	>=media-libs/gupnp-dlna-0.5
	>=media-libs/gstreamer-0.10.35:0.10
	>=media-libs/gst-plugins-base-0.10.35:0.10
	>=net-libs/gssdp-0.11
	>=net-libs/gupnp-0.17.1
	>=net-libs/gupnp-av-0.9
	>=net-libs/libsoup-2.34:2.4
	>=sys-libs/e2fsprogs-libs-1.41.3
	x11-misc/shared-mime-info
	sqlite? (
		>=dev-db/sqlite-3.5:3
		dev-libs/libunistring
	)
	tracker? ( >=app-misc/tracker-0.8.17 )
	transcode? (
		>=media-libs/gst-plugins-bad-0.10.14:0.10
		>=media-plugins/gst-plugins-twolame-0.10.12:0.10
		>=media-plugins/gst-plugins-ffmpeg-0.10.5:0.10
	)
	X? ( >=x11-libs/gtk+-2.90.3:3 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40
"
# Maintainer only
#	>=dev-lang/vala-0.14.1
#	>=net-libs/gupnp-vala-0.10.2
#   dev-libs/libxslt

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--enable-gst-launch-plugin
		--enable-mediathek-plugin
		$(use_enable nls)
		$(use_enable sqlite media-export-plugin)
		$(use_enable test tests)
		$(use_enable tracker tracker-plugin)
		$(use_with X ui)"
}

src_install() {
	gnome2_src_install
	# Autostart file is not placed correctly, bug #402745
	insinto /etc/xdg/autostart
	doins "${D}"/usr/share/applications/rygel.desktop
	rm "${D}"/usr/share/applications/rygel.desktop
}
