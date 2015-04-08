# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsocialweb/libsocialweb-0.25.21-r1.ebuild,v 1.6 2015/04/08 18:04:58 mgorny Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 )
VALA_MIN_API_VERSION="0.12"
VALA_USE_DEPEND="vapigen"

inherit autotools eutils gnome2 python-any-r1 vala

DESCRIPTION="Social web services integration framework"
HOMEPAGE="http://git.gnome.org/browse/libsocialweb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="connman +gnome +introspection +networkmanager vala"

# Introspection is needed for vala bindings
REQUIRED_USE="
	?? ( connman networkmanager )
	vala? ( introspection )
"

# NOTE: coverage testing should not be enabled
RDEPEND="
	>=dev-libs/glib-2.14:2
	>=net-libs/rest-0.7.10

	gnome-base/gconf:2
	gnome-base/libgnome-keyring
	dev-libs/dbus-glib
	dev-libs/json-glib
	net-libs/libsoup:2.4

	gnome? ( >=net-libs/libsoup-gnome-2.25.1:2.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
	networkmanager? ( net-misc/networkmanager )
	!networkmanager? ( connman? ( net-misc/connman ) )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.40
	sys-devel/gettext
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	# Sent upstream, gnome bug 677445
	epatch "${FILESDIR}"/${PN}-0.25.20-gold.patch
	# https://bugzilla.gnome.org/show_bug.cgi?id=686503
	epatch "${FILESDIR}"/${PN}-0.25.21-gmodule.patch

	# Fix namespacing of introspection annotations, bug #426984
	epatch "${FILESDIR}"/${PN}-0.25.20-introspection-annotations.patch

	eautoreconf

	use vala && vala_src_prepare
	gnome2_src_prepare

	# Fix python shebang (FIXME: should be in utils-r1)
	sed -e "/^#!/ s:.*:#!${PYTHON}:" \
		-i  "${S}/tools/glib-ginterface-gen.py" || die
}

src_configure() {
	local myconf

	# NetworkManager always overrides connman support
	use connman && myconf="${myconf} --with-online=connman"
	use networkmanager && myconf="${myconf} --with-online=networkmanager"

	# TODO: enable sys-apps/keyutils support (--without-kernel-keyring)
	gnome2_src_configure \
		--disable-static \
		--disable-gcov \
		--without-kernel-keyring \
		--enable-all-services \
		$(use_enable introspection) \
		$(use_enable vala vala-bindings) \
		$(use_with gnome) \
		--with-online=always \
		${myconf}
}
