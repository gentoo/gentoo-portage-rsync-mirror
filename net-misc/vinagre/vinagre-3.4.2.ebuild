# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vinagre/vinagre-3.4.2.ebuild,v 1.3 2013/01/07 13:44:54 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="VNC client for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/projects/vinagre/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi rdp +ssh spice +telepathy test"

# cairo used in vinagre-tab
# gdk-pixbuf used all over the place
RDEPEND=">=dev-libs/glib-2.28.0:2
	>=x11-libs/gtk+-3.0.3:3
	>=gnome-base/gnome-keyring-1
	>=dev-libs/libxml2-2.6.31:2
	>=net-libs/gtk-vnc-0.4.3[gtk3]
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-themes/gnome-icon-theme

	avahi? ( >=net-dns/avahi-0.6.26[dbus,gtk3] )
	rdp? ( net-misc/rdesktop )
	ssh? ( >=x11-libs/vte-0.20:2.90 )
	spice? ( >=net-misc/spice-gtk-0.5[gtk3] )
	telepathy? (
		dev-libs/dbus-glib
		>=net-libs/telepathy-glib-0.11.6 )
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-lang/vala:0.12
	dev-libs/libxml2
	>=dev-util/intltool-0.40
	dev-util/itstool
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	test? ( app-text/gnome-doc-utils )"
# eautoreconf needds:
#	app-text/yelp-tools
#	gnome-base/gnome-common

src_configure() {
	DOCS="AUTHORS ChangeLog ChangeLog.pre-git NEWS README"
	G2CONF="${G2CONF}
		VALAC=$(type -P valac-0.12)
		--disable-schemas-compile
		$(use_with avahi)
		$(use_enable rdp)
		$(use_enable ssh)
		$(use_enable spice)
		$(use_with telepathy)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	# Remove its own installation of DOCS that go to $PN instead of $P and aren't ecompressed
	rm -rf "${ED}"/usr/share/doc/vinagre
}
