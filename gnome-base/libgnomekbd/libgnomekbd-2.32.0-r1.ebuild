# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnomekbd/libgnomekbd-2.32.0-r1.ebuild,v 1.4 2012/05/21 18:57:27 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit eutils gnome2

DESCRIPTION="Gnome keyboard configuration library"
HOMEPAGE="http://www.gnome.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="test"

# gtk+-2.20 needed for tests
RDEPEND=">=dev-libs/glib-2.18:2
	>=gnome-base/gconf-2.14:2
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libxklavier-5.0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable test tests) --disable-static"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	gnome2_src_prepare

	# Unneeded casts removed
	epatch "${FILESDIR}/${P}-unneeded-casts.patch"

	# Remove GDK_DISPLAY() usage
	epatch "${FILESDIR}/${P}-gdkdisplay-usage.patch"

	# Replace GDK_keyname with GDK_KEY_keyname
	epatch "${FILESDIR}/${P}-gdkkeyname-replace.patch"
}
