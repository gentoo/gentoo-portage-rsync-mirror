# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/seahorse-nautilus/seahorse-nautilus-3.4.0.ebuild,v 1.1 2012/05/13 18:19:31 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no" # --disable-debug disables all assertions
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Nautilus extension for encrypting and decrypting files with GnuPG"
HOMEPAGE="http://www.gnome.org/projects/seahorse/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND=">=app-crypt/gpgme-1.0.0
	>=dev-libs/dbus-glib-0.35
	>=dev-libs/glib-2.18:2
	gnome-base/gconf:2
	gnome-base/gnome-keyring
	>=gnome-base/nautilus-3
	x11-libs/gtk+:3
	x11-libs/libcryptui
	>=x11-libs/libnotify-0.3
	|| (
		=app-crypt/gnupg-1.4*
		=app-crypt/gnupg-2.0* )"
# seahorse-nautilus was formerly part of seahorse-plugins
RDEPEND="${COMMON_DEPEND}
	!app-crypt/seahorse-plugins[nautilus]"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS NEWS README THANKS" # ChangeLog is not used
	# No point in making libnotify optional - nautilus depends on it
	G2CONF="${G2CONF}
		--disable-gpg-check
		--enable-libnotify"
}

src_prepare() {
	gnome2_src_prepare
	# Do not let configure mangle CFLAGS
	sed -e '/^[ \t]*CFLAGS="$CFLAGS \(-g\|-O0\)/d' -i configure.ac configure ||
		die "sed failed"
}
