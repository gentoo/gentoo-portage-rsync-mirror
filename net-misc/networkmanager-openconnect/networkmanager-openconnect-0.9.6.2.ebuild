# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.9.6.2.ebuild,v 1.1 2012/09/13 09:54:53 tetromino Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome.org user

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="
	>=net-misc/networkmanager-0.9.6
	>=dev-libs/dbus-glib-0.74
	dev-libs/libxml2:2
	gnome-base/libgnome-keyring
	>=net-misc/openconnect-3.02
	gtk? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gconf:2
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig"

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-gtkver=3
		$(use_with gtk gnome)
		$(use_with gtk authdlg)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	enewgroup nm-openconnect
	enewuser nm-openconnect -1 -1 -1 nm-openconnect
}
