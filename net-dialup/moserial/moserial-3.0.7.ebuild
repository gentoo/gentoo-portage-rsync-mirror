# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/moserial/moserial-3.0.7.ebuild,v 1.4 2012/10/16 04:40:49 blueness Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="moserial is a clean, friendly gtk-based serial terminal"
HOMEPAGE="http://live.gnome.org/moserial"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/gtk+-3.0.0:3"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
