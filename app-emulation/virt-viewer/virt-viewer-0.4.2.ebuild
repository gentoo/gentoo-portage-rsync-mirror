# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.4.2.ebuild,v 1.6 2012/05/03 18:49:06 jdhore Exp $

EAPI=4
inherit gnome2

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 sasl spice +vnc"

RDEPEND=">=app-emulation/libvirt-0.6
	>=dev-libs/libxml2-2.6
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? (
		>=x11-libs/gtk+-2.10:2
		>=gnome-base/libglade-2.6
		)
	spice? ( >=net-misc/spice-gtk-0.6[sasl?,gtk3?] )
	vnc? ( >=net-libs/gtk-vnc-0.4.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="|| ( spice vnc )"

pkg_setup() {
	G2CONF="--disable-plugin $(use_with spice spice-gtk)"
	G2CONF="${G2CONF} $(use_with vnc gtk-vnc)"
	use gtk3 && G2CONF="${G2CONF} --with-gtk=3.0"
	use gtk3 || G2CONF="${G2CONF} --with-gtk=2.0"
}
