# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netspeed-plugin/xfce4-netspeed-plugin-0.1.ebuild,v 1.6 2012/11/28 12:25:59 ssuominen Exp $

EAPI=5
inherit multilib xfconf

DESCRIPTION="A network transfer rate monitoring panel plug-in, inspired by Gnome's Netspeed applet"
HOMEPAGE="http://code.google.com/p/xfce4-netspeed-plugin/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/libgtop-2
	x11-libs/gtk+:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		)

	DOCS=( AUTHORS README )
}
