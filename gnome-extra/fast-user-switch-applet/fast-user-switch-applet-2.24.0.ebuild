# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/fast-user-switch-applet/fast-user-switch-applet-2.24.0.ebuild,v 1.14 2012/05/05 06:25:21 jdhore Exp $

EAPI="2"

inherit eutils gnome2 autotools

DESCRIPTION="Fast User Switching Applet for Gnome Desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.8:2
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	>=gnome-base/libglade-2.0:2.0
	gnome-base/libgnomeui
	gnome-base/gconf:2
	gnome-base/gdm
	x11-libs/libXmu
	x11-libs/libXau
	x11-libs/libSM"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	virtual/pkgconfig
	>=sys-devel/autoconf-2.53
	>=dev-util/intltool-0.35
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2
	~app-text/docbook-xml-dtd-4.3"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --with-gdm-config=/usr/share/gdm/defaults.conf"
}

src_prepare() {
	gnome2_src_prepare

	# Need libgnomeui for help display; bug #263367
	epatch "${FILESDIR}"/${P}-libgnomeui.patch

	eautoreconf
}
