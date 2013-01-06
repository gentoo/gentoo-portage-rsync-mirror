# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/glunarclock/glunarclock-0.34.1.ebuild,v 1.6 2012/05/05 04:53:50 jdhore Exp $

EAPI=2
GCONF_DEBUG=no
inherit gnome2

DESCRIPTION="Gnome Moon Phase Panel Applet"
HOMEPAGE="http://glunarclock.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.14:2
	>=dev-libs/glib-2.12:2
	>=gnome-base/gconf-2.8
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	sys-devel/gettext
	app-text/gnome-doc-utils
	app-text/rarian
	dev-libs/libxslt"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="--disable-dependency-tracking"
}
