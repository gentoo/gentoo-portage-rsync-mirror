# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/mate-bluetooth/mate-bluetooth-1.6.0-r1.ebuild,v 1.3 2014/03/10 22:37:53 tomwij Exp $

EAPI="5"

GCONF_DEBUG="yes"

inherit autotools gnome2 multilib udev user versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Fork of bluez-gnome focused on integration with MATE"
HOMEPAGE="http://mate-desktop.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+introspection test"

RESTRICT="test"

RDEPEND="app-text/rarian:0
	app-mobilephone/obexd:0
	>=dev-libs/dbus-glib-0.74:0
	>=dev-libs/glib-2.25.7:2
	>=dev-libs/libunique-1:1
	net-wireless/bluez:0=
	>=x11-libs/gtk+-2.19.1:2
	x11-libs/libX11:0
	x11-libs/libXi:0
	>=x11-libs/libnotify-0.7:0
	virtual/libintl:0
	virtual/udev:0
	introspection? ( >=dev-libs/gobject-introspection-0.6.7:0 )"

DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/mate-doc-utils-1.2.1:0
	>=app-text/scrollkeeper-dtd-1:1.0
	dev-libs/libxml2:2
	>=dev-util/intltool-0.35:*
	>=mate-base/mate-common-1.6
	sys-devel/gettext:*
	x11-proto/xproto:0
	virtual/pkgconfig:*"

src_prepare() {
	# Fix test
	sed -i 's:applet/bluetooth-:applet/mate-bluetooth-:g' \
		po/POTFILES.skip || die

	mate-doc-prepare --force --copy || die
	mate-doc-common --copy || die
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_enable introspection) \
		--disable-desktop-update \
		--disable-icon-update \
		--disable-moblin \
		--disable-schemas-compile
}

DOCS="AUTHORS README NEWS ChangeLog"

src_install() {
	gnome2_src_install

	insinto "$(get_udevdir)"/rules.d/
	doins "${FILESDIR}"/80-mate-rfkill.rules
}

pkg_postinst() {
	gnome2_pkg_postinst

	enewgroup plugdev

	elog "Don't forget to add yourself to the plugdev group "
	elog "if you want to be able to control the bluetooth transmitter."
}
