# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-logger/telepathy-logger-0.4.0-r1.ebuild,v 1.1 2012/10/09 23:45:43 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 python virtualx

DESCRIPTION="Telepathy Logger is a session daemon that should be activated whenever telepathy is being used."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Logger"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-linux"
IUSE="+introspection"

RDEPEND=">=dev-libs/glib-2.25.11:2
	>=sys-apps/dbus-1.1
	>=dev-libs/dbus-glib-0.82
	>=net-libs/telepathy-glib-0.18.0[introspection?]
	dev-libs/libxml2
	dev-libs/libxslt
	dev-db/sqlite:3
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		$(use_enable introspection)
		--enable-debug
		--enable-public-extensions
		--disable-coding-style-checks
		--disable-Werror
		--disable-static"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	gnome2_src_prepare
}

src_test() {
	gnome2_environment_reset
	Xemake check || die "make check failed"
}
