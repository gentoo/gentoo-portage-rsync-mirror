# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp/gupnp-0.20.6.ebuild,v 1.2 2013/10/15 09:44:16 jlec Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.14"
VALA_USE_DEPEND="vapigen"
# FIXME: Claims to works with python3 but appears to be wishful thinking
PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml"

inherit gnome2 python-r1 vala

DESCRIPTION="An object-oriented framework for creating UPnP devs and control points"
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0/4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="connman +introspection kernel_linux networkmanager"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
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

src_prepare() {
	use introspection && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	local backend=unix
	use kernel_linux && backend=linux
	use connman && backend=connman
	use networkmanager && backend=network-manager

	gnome2_src_configure \
		$(use_enable introspection) \
		--disable-static \
		--with-context-manager=${backend}
}

src_install() {
	gnome2_src_install
	python_parallel_foreach_impl python_doscript tools/gupnp-binding-tool
}
