# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnome-disk-utility/gnome-disk-utility-2.32.1-r1.ebuild,v 1.10 2012/05/04 09:17:26 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Disk Utility for GNOME using udisks"
HOMEPAGE="http://git.gnome.org/browse/gnome-disk-utility"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86"
IUSE="avahi doc fat gnome-keyring nautilus remote-access"

CDEPEND="
	>=dev-libs/glib-2.22:2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libunique-1:1
	>=x11-libs/gtk+-2.20:2
	=sys-fs/udisks-1.0*:0[remote-access?]
	>=dev-libs/libatasmart-0.14
	>=x11-libs/libnotify-0.6.1
	avahi? ( >=net-dns/avahi-0.6.25[gtk] )
	gnome-keyring? ( gnome-base/libgnome-keyring )
	nautilus? ( >=gnome-base/nautilus-2.24 )
"
RDEPEND="${CDEPEND}
	x11-misc/xdg-utils
	fat? ( sys-fs/dosfstools )"
DEPEND="${CDEPEND}
	sys-devel/gettext
	gnome-base/gnome-common
	app-text/docbook-xml-dtd:4.1.2
	app-text/rarian
	app-text/gnome-doc-utils

	virtual/pkgconfig
	>=dev-util/intltool-0.35
	>=dev-util/gtk-doc-am-1.13

	doc? ( >=dev-util/gtk-doc-1.3 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable avahi avahi-ui)
		$(use_enable nautilus)
		$(use_enable remote-access)
		$(use_enable gnome-keyring)"
	DOCS="AUTHORS NEWS README TODO"
}

src_prepare() {
	sed -i \
		-e '/printf/s:nautilus:xdg-open:' \
		src/palimpsest/gdu-section-volumes.c || die #350919

	# Keep avahi optional, upstream bug #631986
	epatch "${FILESDIR}/${PN}-2.32.1-optional-avahi.patch"

	# Force GduPresentable ids to be UTF-8 to solve crashes and freezes, upstream bug #616198
	epatch "${FILESDIR}/${PN}-2.32.1-non-utf8-crash.patch"

	intltoolize --force --copy --automake || die
	eautoreconf
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}
