# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.18.4.ebuild,v 1.6 2013/03/29 13:41:06 ago Exp $

EAPI="4"

inherit eutils gnome.org multilib

DESCRIPTION="An object-oriented framework for creating UPnP devs and control points"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ppc ppc64 ~sparc x86"
IUSE="connman +introspection kernel_linux networkmanager"

RDEPEND=">=net-libs/gssdp-0.11.2[introspection?]
	>=net-libs/libsoup-2.28.2:2.4[introspection?]
	>=dev-libs/glib-2.24:2
	dev-libs/libxml2
	|| (
		>=sys-apps/util-linux-2.16
		<sys-libs/e2fsprogs-libs-1.41.8 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.4 )
	connman? (
		>=dev-libs/glib-2.28
		>=net-misc/connman-0.80 )
	networkmanager? ( >=dev-libs/glib-2.26 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

DOCS="AUTHORS ChangeLog NEWS README"

src_configure() {
	local backend=unix
	use kernel_linux && backend=linux
	use connman && backend=connman
	use networkmanager && backend=network-manager

	econf \
		$(use_enable introspection) \
		--disable-static \
		--disable-dependency-tracking \
		--disable-gtk-doc \
		--with-context-manager=${backend}
}

src_install() {
	default
	# Remove pointless .la files
	find "${D}" -name '*.la' -delete
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libgupnp-1.0.so.3
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libgupnp-1.0.so.3
}
