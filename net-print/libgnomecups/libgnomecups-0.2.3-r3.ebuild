# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.2.3-r3.ebuild,v 1.1 2012/08/07 11:21:31 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit eutils gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2:2
	>=net-print/cups-1.3.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.28"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static"
	DOCS="AUTHORS ChangeLog NEWS"
}

src_prepare() {
	epatch "${FILESDIR}"/enablenet.patch

	# Fix .pc file per bug #235013
	epatch "${FILESDIR}"/${P}-pkgconfig.patch

	# Upstream fix for g_list_find_custom() argument order
	epatch "${FILESDIR}/${P}-g_list_find_custom.patch"

	# >=glib-2.31 compat, bug #400789, https://bugzilla.gnome.org/show_bug.cgi?id=664930
	epatch "${FILESDIR}/${P}-glib.h.patch"

	# cups-1.6 compat, bug #428812
	epatch "${FILESDIR}/${P}-cups-1.6.patch"

	gnome2_src_prepare
}
