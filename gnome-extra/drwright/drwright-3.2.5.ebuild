# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/drwright/drwright-3.2.5.ebuild,v 1.2 2012/05/05 06:25:23 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="A GNOME 3 tool that forces you to take regular breaks to prevent RSI"
HOMEPAGE="http://git.gnome.org/browse/drwright"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.26.0:2
	>=x11-libs/gtk+-3.0.0:3
	>=gnome-base/gnome-settings-daemon-2.91.8
	>=gnome-base/gnome-control-center-3.2
	>=x11-libs/libnotify-0.7
	media-libs/libcanberra[gtk3]
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	x11-proto/scrnsaverproto
	sys-devel/gettext
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS"
	G2CONF="${G2CONF} --disable-static"
}
