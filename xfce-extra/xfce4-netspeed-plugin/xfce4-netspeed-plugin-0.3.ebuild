# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netspeed-plugin/xfce4-netspeed-plugin-0.3.ebuild,v 1.2 2013/02/20 11:39:37 ssuominen Exp $

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
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

pkg_setup() {
	XFCONF=(
		--libexecdir="${EPREFIX}"/usr/$(get_libdir)
		)

	DOCS=( AUTHORS README )
}
