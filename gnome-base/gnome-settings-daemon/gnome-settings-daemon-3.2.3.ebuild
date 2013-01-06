# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-settings-daemon/gnome-settings-daemon-3.2.3.ebuild,v 1.5 2012/12/11 09:33:51 ssuominen Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 virtualx

DESCRIPTION="Gnome Settings Daemon"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="+colord +cups debug packagekit policykit +short-touchpad-timeout smartcard +udev"

# Latest gsettings-desktop-schemas is needed due to commit e8d1de92
# Latest gnome-desktop needed to fix the DPMS timeout bug #385063
# colord-0.1.13 needed to avoid polkit errors in CreateProfile and CreateDevice
# upower-0.9.11 needed for UpSleepKind
COMMON_DEPEND=">=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.29.14:2
	>=x11-libs/gtk+-3.1.10:3
	>=gnome-base/gconf-2.6.1:2
	>=gnome-base/libgnomekbd-2.91.1
	>=gnome-base/gnome-desktop-3.2.0-r1:3
	>=gnome-base/gsettings-desktop-schemas-0.1.7.1
	media-fonts/cantarell
	media-libs/fontconfig
	>=media-libs/lcms-2.2:2
	media-libs/libcanberra[gtk3]
	>=media-sound/pulseaudio-0.9.16
	>=sys-power/upower-0.9.11
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/libnotify-0.7.3
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXxf86misc
	>=x11-libs/libxklavier-5.0
	>=media-sound/pulseaudio-0.9.16

	colord? ( >=x11-misc/colord-0.1.13 )
	cups? ( >=net-print/cups-1.4[dbus] )
	packagekit? (
		virtual/udev[gudev]
		>=app-admin/packagekit-base-0.6.12 )
	policykit? (
		>=sys-auth/polkit-0.97
		>=sys-apps/dbus-1.1.2[X] )
	smartcard? ( >=dev-libs/nss-3.11.2 )
	udev? ( virtual/udev[gudev] )"
# Themes needed by g-s-d, gnome-shell, gtk+:3 apps to work properly
# <gnome-color-manager-3.1.1 has file collisions with g-s-d-3.1.x
# <gnome-power-manager-3.1.3 has file collisions with g-s-d-3.1.x
RDEPEND="${COMMON_DEPEND}
	gnome-base/dconf
	>=x11-themes/gnome-themes-standard-2.91
	>=x11-themes/gnome-icon-theme-2.91
	>=x11-themes/gnome-icon-theme-symbolic-2.91
	!<gnome-base/gnome-control-center-2.22
	!<gnome-extra/gnome-color-manager-3.1.1
	!<gnome-extra/gnome-power-manager-3.1.3"
# xproto-7.0.15 needed for power plugin
DEPEND="${COMMON_DEPEND}
	cups? ( sys-apps/sed )
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	x11-proto/inputproto
	x11-proto/kbproto
	x11-proto/xf86miscproto
	>=x11-proto/xproto-7.0.15"

pkg_setup() {
	# README is empty
	DOCS="AUTHORS NEWS ChangeLog MAINTAINERS"
	G2CONF="${G2CONF}
		--disable-static
		--disable-schemas-compile
		--enable-gconf-bridge
		--with-pnpids=${EPREFIX}/usr/share/libgnome-desktop-3.0/pnp.ids
		$(use_enable colord color)
		$(use_enable cups)
		$(use_enable debug)
		$(use_enable debug more-warnings)
		$(use_enable packagekit)
		$(use_enable policykit polkit)
		$(use_enable smartcard smartcard-support)
		$(use_enable udev gudev)"
}

src_prepare() {
	# Backport patch from git master branch (not in gnome-3-2 branch yet)
	# fixing loading color profiles at startup
	epatch "${FILESDIR}/${PN}-3.2.0-color-unbreak-loading-profiles.patch"

	# https://bugzilla.gnome.org/show_bug.cgi?id=621836
	# Apparently this change severely affects touchpad usability for some
	# people, so revert it if USE=short-touchpad-timeout.
	# Revisit if/when upstream adds a setting for customizing the timeout.
	use short-touchpad-timeout &&
		epatch "${FILESDIR}/${PN}-3.0.2-short-touchpad-timeout.patch"

	# Make colord optional; requires eautoreconf
	epatch "${FILESDIR}/${PN}-3.2.1-optional-colord.patch"

	# bug #428816, https://bugzilla.gnome.org/show_bug.cgi?id=679761
	epatch "${FILESDIR}/${PN}-3.4.2-cups-1.6.patch"

	eautoreconf

	gnome2_src_prepare
}

src_test() {
	Xemake check
}

src_install() {
	gnome2_src_install

	echo 'GSETTINGS_BACKEND="dconf"' >> 51gsettings-dconf
	doenvd 51gsettings-dconf || die "doenvd failed"
}
