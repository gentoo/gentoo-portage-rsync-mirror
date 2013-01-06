# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.30.6-r1.ebuild,v 1.8 2012/05/03 06:01:03 jdhore Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2 autotools

DESCRIPTION="GNOME webbrowser based on Webkit"
HOMEPAGE="http://projects.gnome.org/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="avahi doc +introspection networkmanager +nss test"

# TODO: add seed support
RDEPEND=">=dev-libs/glib-2.19.7:2
	>=x11-libs/gtk+-2.19.5:2[introspection?]
	>=dev-libs/libxml2-2.6.12:2
	>=dev-libs/libxslt-1.1.7
	>=x11-libs/startup-notification-0.5
	>=x11-libs/libnotify-0.4
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/gconf-2:2
	>=app-text/iso-codes-0.35
	>=net-libs/webkit-gtk-1.2.3:2[introspection?]
	>=net-libs/libsoup-gnome-2.29.91:2.4
	>=gnome-base/gnome-keyring-2.26

	x11-libs/libICE
	x11-libs/libSM

	>=app-misc/ca-certificates-20080514-r2
	x11-themes/gnome-icon-theme

	avahi? ( >=net-dns/avahi-0.6.22 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	networkmanager? ( net-misc/networkmanager )
	nss? ( dev-libs/nss )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )
	gnome-base/gnome-common"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-maintainer-mode
		--with-distributor-name=Gentoo
		$(use_enable avahi zeroconf)
		$(use_enable introspection)
		$(use_enable networkmanager network-manager)
		$(use_enable nss)
		$(use_enable test tests)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# introspection: Fix build by telling g-ir-scanner what the prefix is
	epatch "${FILESDIR}"/${P}-introspection-prefix.patch

	# DBUS_LIBS is needed for libephymain.la
	epatch "${FILESDIR}"/${P}-dbus-fix.patch

	# Declare ability to handle http and https
	epatch "${FILESDIR}"/${P}-mime-handler.patch

	# Do not crash when clearing the passwords from prefs dialog, upstream bug #606933
	epatch "${FILESDIR}"/${P}-clearing-passwd.patch

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
	gnome2_src_prepare
}

src_compile() {
	# Fix sandbox error with USE="introspection" and "doc"
	# https://bugs.webkit.org/show_bug.cgi?id=35471
	addpredict "$(unset HOME; echo ~)/.local"
	gnome2_src_compile
}
