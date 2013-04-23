# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/glib-networking/glib-networking-2.36.1.ebuild,v 1.1 2013/04/23 19:10:15 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 virtualx

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="+gnome +libproxy smartcard +ssl test"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"

RDEPEND="
	>=dev-libs/glib-2.35.8:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.4.6-r3:= )
	smartcard? (
		>=app-crypt/p11-kit-0.8
		>=net-libs/gnutls-2.12.8:=[pkcs11] )
	ssl? (
		app-misc/ca-certificates
		>=net-libs/gnutls-2.11.0:= )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
	test? ( sys-apps/dbus[X] )
"
# eautoreconf needs >=sys-devel/autoconf-2.65:2.5

src_prepare() {
	# Failing tests, upstream #695062 (will be fixed in 2.38)
	sed -e '/tls.connection.simultaneous-async-rehandshake/,+1 d' \
		-e '/tls.connection.simultaneous-sync-rehandshake/,+1 d' \
		-i tls/tests/connection.c || die
	gnome2_src_prepare
}

src_configure() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	gnome2_src_configure \
		--disable-static \
		--with-ca-certificates="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt \
		$(use_with gnome gnome-proxy) \
		$(use_with libproxy) \
		$(use_with smartcard pkcs11) \
		$(use_with ssl gnutls)
}

src_test() {
	Xemake check
}
