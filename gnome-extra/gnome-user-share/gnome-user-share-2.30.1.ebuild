# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-user-share/gnome-user-share-2.30.1.ebuild,v 1.10 2012/05/06 05:39:00 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2 multilib

DESCRIPTION="Personal file sharing for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# FIXME: could libnotify be made optional ?
#        is consolekit needed or not ?
# FIXME: gnome-bluetooth is a hard-dep
# bluetooth is pure runtime dep (dbus)
RDEPEND=">=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.14:2
	>=app-mobilephone/obex-data-server-0.4
	>=dev-libs/dbus-glib-0.70
	dev-libs/libunique:1
	>=gnome-base/gconf-2.10:2
	>=gnome-base/nautilus-2
	media-libs/libcanberra[gtk]
	>=net-wireless/gnome-bluetooth-2.27.7.2:2
	>=net-wireless/bluez-4.18
	>=sys-apps/dbus-1.1.1
	>=www-apache/mod_dnssd-0.6
	=www-servers/apache-2.2*[apache2_modules_dav,apache2_modules_dav_fs,apache2_modules_authn_file,apache2_modules_auth_digest,apache2_modules_authz_groupfile]
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--with-httpd=apache2
		--with-modules-path=/usr/$(get_libdir)/apache2/modules/"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	# nautilus does not need la files
	find "${ED}" -name "*.la" -delete
}
