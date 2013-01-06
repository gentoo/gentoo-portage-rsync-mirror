# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-3.0.2-r201.ebuild,v 1.9 2012/10/28 16:32:46 armin76 Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="fat gnome-keyring nautilus remote-access"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86"

CDEPEND="
	>=dev-libs/glib-2.22:2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libunique-2.90.1:3
	>=gnome-base/libgdu-${PV}[gnome-keyring?]
	>=x11-libs/gtk+-2.90.7:3
	>=x11-libs/libnotify-0.6.1

	gnome-keyring? ( gnome-base/libgnome-keyring )
	nautilus? ( >=gnome-base/nautilus-2.24.0 )
"
RDEPEND="${CDEPEND}
	=sys-fs/udisks-1.0*:0[remote-access?]
	x11-misc/xdg-utils
	fat? ( sys-fs/dosfstools )"
DEPEND="${CDEPEND}
	sys-devel/gettext
	gnome-base/gnome-common
	app-text/docbook-xml-dtd:4.1.2
	app-text/rarian
	app-text/gnome-doc-utils

	virtual/pkgconfig
	>=dev-util/intltool-0.35"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable nautilus)
		$(use_enable remote-access)
		$(use_enable gnome-keyring)"
	DOCS="AUTHORS NEWS README TODO"
}

src_prepare() {
	sed -e '/printf/s:nautilus:xdg-open:' \
		-i src/palimpsest/gdu-section-volumes.c || die "#350919"

	# Split libgdu out of gnome-disk-utility
	epatch "${FILESDIR}/${PN}-3.0.2-separate-libgdu.patch"

	# Keep nautilus extension working on Gnome2 setups
	epatch "${FILESDIR}/${PN}-3.0.2-nautilus2-compat-r201.patch"

	intltoolize --force --copy --automake || die
	eautoreconf

	gnome2_src_prepare
}
