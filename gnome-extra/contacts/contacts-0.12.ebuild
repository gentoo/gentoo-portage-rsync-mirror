# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/contacts/contacts-0.12.ebuild,v 1.8 2012/05/05 06:25:23 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME_TARBALL_SUFFIX="bz2"

inherit autotools eutils gnome2

DESCRIPTION="A small, lightweight addressbook for GNOME"
HOMEPAGE="http://pimlico-project.org/contacts.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dbus gnome"

RDEPEND=">=gnome-extra/evolution-data-server-1.8
	>=x11-libs/gtk+-2.6:2
	dbus? (
		dev-libs/dbus-glib
		sys-apps/dbus )
	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/gnome-vfs-2 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

pkg_setup() {
	# README is empty
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="${G2CONF}
		$(use_enable dbus)
		$(use_enable gnome gconf)
		$(use_enable gnome gnome-vfs)"
}

src_prepare() {
	# Fix compilation with USE="-dbus", bug #247519, upstream bug #628614
	epatch "${FILESDIR}/${PN}-0.9-dbus.patch"

	# Fix compilation with gmake-3.82, bug #333647, upstream bug #628615
	epatch "${FILESDIR}/${PN}-0.11-fix-make-3.82.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}
