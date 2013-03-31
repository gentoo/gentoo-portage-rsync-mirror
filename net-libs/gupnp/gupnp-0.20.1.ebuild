# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.20.1.ebuild,v 1.2 2013/03/30 23:36:36 eva Exp $

EAPI="5"
VALA_MIN_API_VERSION="0.14"
VALA_USE_DEPEND="vapigen"

inherit eutils gnome.org vala

DESCRIPTION="An object-oriented framework for creating UPnP devs and control points"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="connman +introspection kernel_linux networkmanager"

RDEPEND="
	>=net-libs/gssdp-0.13.0:0=[introspection?]
	>=net-libs/libsoup-2.28.2:2.4[introspection?]
	>=dev-libs/glib-2.24:2
	dev-libs/libxml2
	|| (
		>=sys-apps/util-linux-2.16
		<sys-libs/e2fsprogs-libs-1.41.8 )
	introspection? (
			>=dev-libs/gobject-introspection-0.6.4
			$(vala_depend) )
	connman? (
		>=dev-libs/glib-2.28:2
		>=net-misc/connman-0.80 )
	networkmanager? ( >=dev-libs/glib-2.26:2 )
	!net-libs/gupnp-vala
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local backend=unix
	use kernel_linux && backend=linux
	use connman && backend=connman
	use networkmanager && backend=network-manager

	econf \
		$(use_enable introspection) \
		--disable-static \
		--disable-gtk-doc \
		--with-context-manager=${backend}
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README"
	default
	prune_libtool_files
}
