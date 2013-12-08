# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openswan/networkmanager-openswan-0.9.8.4.ebuild,v 1.3 2013/12/08 19:30:25 pacho Exp $

EAPI="5"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome.org gnome2-utils

DESCRIPTION="NetworkManager Openswan plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk"

RDEPEND="
	>=net-misc/networkmanager-0.9.8:=
	>=dev-libs/dbus-glib-0.74
	net-misc/openswan
	gtk? (
		>=x11-libs/gtk+-3.0.0:3
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	gnome2_disable_deprecation_warning
	default
}

src_configure() {
	econf \
		--disable-more-warnings \
		--disable-static \
		--with-dist-version=Gentoo \
		--with-gtkver=3 \
		$(use_with gtk gnome)
}

src_install() {
	default
	prune_libtool_files --modules
}
