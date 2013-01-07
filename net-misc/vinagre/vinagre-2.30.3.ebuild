# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vinagre/vinagre-2.30.3.ebuild,v 1.11 2013/01/07 13:44:54 tetromino Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="VNC client for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/projects/vinagre/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="applet avahi +ssh +telepathy test"

# Telepathy-glib version in tarball is wrong:
# https://bugzilla.gnome.org/show_bug.cgi?id=614716
RDEPEND=">=dev-libs/glib-2.17:2
	dev-libs/dbus-glib
	>=x11-libs/gtk+-2.16:2
	>=gnome-base/gconf-2.16
	>=net-libs/gtk-vnc-0.3.10
	>=gnome-base/gnome-keyring-1
	x11-libs/libX11
	applet? ( || ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 ) )
	avahi? (
		>=dev-libs/libxml2-2.6.31
		>=net-dns/avahi-0.6.22[dbus,gtk] )
	ssh? (
		>=dev-libs/libxml2-2.6.31
		>=x11-libs/vte-0.20:0 )
	telepathy? ( >=net-libs/telepathy-glib-0.10 )"

DEPEND="${RDEPEND}
	gnome-base/gnome-common
	>=dev-lang/perl-5
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	test? ( ~app-text/docbook-xml-dtd-4.3 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		$(use_enable avahi)
		$(use_enable applet)
		$(use_enable ssh)
		$(use_enable telepathy)"
}

src_install() {
	gnome2_src_install

	find "${D}" -name "*.la" -delete || die "remove of la files failed"

	# Remove it's own installation of DOCS that go to $PN instead of $P and aren't ecompressed
	rm -rf "${D}"/usr/share/doc/vinagre
}
