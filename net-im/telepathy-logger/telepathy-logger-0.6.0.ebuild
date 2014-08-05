# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-logger/telepathy-logger-0.6.0.ebuild,v 1.11 2014/08/05 18:34:06 mrueg Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit gnome2 python-any-r1 virtualx

DESCRIPTION="Telepathy Logger is a session daemon that should be activated whenever telepathy is being used"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Logger"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0/3"
KEYWORDS="alpha amd64 ~arm ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE="+introspection"

RDEPEND="
	>=dev-libs/glib-2.25.11:2
	>=sys-apps/dbus-1.1
	>=dev-libs/dbus-glib-0.82
	>=net-libs/telepathy-glib-0.19.2[introspection?]
	dev-libs/libxml2
	dev-libs/libxslt
	dev-db/sqlite:3
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"

src_configure() {
	G2CONF="${G2CONF}
		$(use_enable introspection)
		--enable-debug
		--enable-public-extensions
		--disable-coding-style-checks
		--disable-Werror
		--disable-static"
	gnome2_src_configure
}

src_test() {
	gnome2_environment_reset
	Xemake check || die "make check failed"
}
