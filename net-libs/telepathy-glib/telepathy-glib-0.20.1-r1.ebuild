# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-glib/telepathy-glib-0.20.1-r1.ebuild,v 1.6 2013/03/27 10:30:26 ago Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{5,6,7} )
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit eutils gnome2-utils python-r1 vala virtualx

DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="debug +introspection +vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND="
	>=dev-libs/glib-2.32.0:2
	>=dev-libs/dbus-glib-0.90
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/gtk-doc-am
	virtual/pkgconfig
	vala? ( $(vala_depend) )
	${PYTHON_DEPS}
"

src_prepare() {
	use vala && vala_src_prepare
	default
}

src_configure() {
	python_export_best
	econf --disable-static \
		--disable-installed-tests \
		$(use_enable debug backtrace) \
		$(use_enable debug debug-cache) \
		$(use_enable introspection) \
		$(use_enable vala vala-bindings)
}

src_test() {
	gnome2_environment_reset
	unset DBUS_SESSION_BUS_ADDRESS
	# Needs dbus for tests (auto-launched)
	Xemake -j1 check
}

src_install() {
	default
	prune_libtool_files
}
