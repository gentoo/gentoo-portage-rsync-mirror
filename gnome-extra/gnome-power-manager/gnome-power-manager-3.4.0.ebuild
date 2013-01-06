# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-power-manager/gnome-power-manager-3.4.0.ebuild,v 1.3 2012/07/02 22:11:52 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit eutils gnome2 virtualx

DESCRIPTION="Gnome Power Manager"
HOMEPAGE="http://www.gnome.org/projects/gnome-power-manager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="test"

# FIXME: Interactive testsuite (upstream ? I'm so...pessimistic)
RESTRICT="test"

# Need gtk+-3.3.8 for bug #416039
COMMON_DEPEND=">=dev-libs/glib-2.31.10
	>=x11-libs/gtk+-3.3.8:3
	>=x11-libs/cairo-1.0.0
	>=sys-power/upower-0.9.1"
RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-icon-theme-symbolic"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-sgml-dtd:4.1
	app-text/docbook-sgml-utils
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	sys-devel/gettext
	x11-proto/randrproto
	virtual/pkgconfig
	test? ( sys-apps/dbus )"

# docbook-sgml-utils and docbook-sgml-dtd-4.1 used for creating man pages
# (files under ${S}/man).
# docbook-xml-dtd-4.4 and -4.1.2 are used by the xml files under ${S}/docs.

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable test tests)
		--disable-strict
		--enable-compile-warnings=minimum
		--disable-schemas-compile"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Drop debugger CFLAGS from configure
	# XXX: touch configure.ac only if running eautoreconf, otherwise
	# maintainer mode gets triggered -- even if the order is correct
	sed -e 's:^CPPFLAGS="$CPPFLAGS -g"$::g' \
		-i configure || die "debugger sed failed"
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "Test phase failed"
}
