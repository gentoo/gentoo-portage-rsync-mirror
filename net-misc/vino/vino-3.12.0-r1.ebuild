# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vino/vino-3.12.0-r1.ebuild,v 1.1 2014/09/07 13:50:29 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="An integrated VNC server for GNOME"
HOMEPAGE="https://wiki.gnome.org/Projects/Vino"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="avahi crypt gnome-keyring ipv6 jpeg networkmanager ssl +telepathy +zlib"
# bug #394611; tight encoding requires zlib encoding
REQUIRED_USE="jpeg? ( zlib )"

# cairo used in vino-fb
# libSM and libICE used in eggsmclient-xsmp
RDEPEND="
	>=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-3.0.0:3
	>=dev-libs/libgcrypt-1.1.90:0=

	dev-libs/dbus-glib
	x11-libs/cairo:=
	x11-libs/pango[X]
	x11-libs/libICE
	x11-libs/libX11
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libSM
	x11-libs/libXtst

	>=x11-libs/libnotify-0.7.0:=

	avahi? ( >=net-dns/avahi-0.6:=[dbus] )
	crypt? ( >=dev-libs/libgcrypt-1.1.90:0= )
	gnome-keyring? ( app-crypt/libsecret )
	jpeg? ( virtual/jpeg:0= )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	ssl? ( >=net-libs/gnutls-2.2.0:= )
	telepathy? ( >=net-libs/telepathy-glib-0.18 )
	zlib? ( sys-libs/zlib:= )
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	>=dev-util/intltool-0.50
	virtual/pkgconfig
	app-crypt/libsecret
"
# libsecret is always required at build time per bug 322763

src_configure() {
	gnome2_src_configure \
		--disable-http-server \
		--with-gcrypt \
		$(use_with avahi) \
		$(use_with crypt gcrypt) \
		$(use_enable ipv6) \
		$(use_with jpeg) \
		$(use_with gnome-keyring secret) \
		$(use_with networkmanager network-manager) \
		$(use_with ssl gnutls) \
		$(use_with telepathy) \
		$(use_with zlib)
}
