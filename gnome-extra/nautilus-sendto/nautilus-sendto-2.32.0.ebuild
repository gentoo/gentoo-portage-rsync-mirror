# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-2.32.0.ebuild,v 1.7 2012/12/15 18:52:58 tetromino Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2 multilib

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="cdr doc gajim +mail pidgin upnp-av"

RDEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.25.9:2
	>=gnome-base/nautilus-2.14
	cdr? ( >=app-cdr/brasero-2.26.0[nautilus] )
	gajim? (
		net-im/gajim
		>=dev-libs/dbus-glib-0.60 )
	mail? ( >=gnome-extra/evolution-data-server-1.5.3 )
	pidgin? (
		>=net-im/pidgin-2.0.0
		>=dev-libs/dbus-glib-0.60 )
	upnp-av? ( >=net-libs/gupnp-0.13.0 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.9 )"
# Needed for eautoreconf
#	>=gnome-base/gnome-common-0.12
#	dev-util/gtk-doc-am

_use_plugin() {
	if use ${1}; then
		G2CONF="${G2CONF}${2:-"${1}"},"
	fi
}

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--with-plugins=removable-devices,"
	_use_plugin cdr nautilus-burn
	_use_plugin mail evolution
	_use_plugin pidgin
	_use_plugin gajim
	_use_plugin upnp-av upnp
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "failed to delete *.la files"
}
