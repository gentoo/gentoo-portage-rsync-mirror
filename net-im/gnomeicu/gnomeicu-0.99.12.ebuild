# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.99.12.ebuild,v 1.12 2012/05/04 06:22:13 jdhore Exp $

EAPI=2
inherit gnome2

DESCRIPTION="Gnome ICQ Client"
SRC_URI="mirror://sourceforge/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc sparc x86"

RDEPEND="x11-libs/gtk+:2
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=sys-libs/gdbm-1.8.0
	>=gnome-base/libglade-2.0.0
	>=app-text/scrollkeeper-0.3.5
	>=gnome-base/gconf-2.0
	sys-devel/gettext
	spell? ( >=app-text/gtkspell-2.0.4:2 )
	x11-libs/libXScrnSaver"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.22
	x11-proto/scrnsaverproto"

IUSE="spell"

src_prepare () {
	gnome2_omf_fix "${S}/doc/C/Makefile.in" "${S}/doc/omf.make" "${S}/doc/uk/Makefile.in"
}

src_configure() {
	G2CONF=$(use_enable spell)
	gnome2_src_configure
}

DOCS="AUTHORS CREDITS ChangeLog README"
