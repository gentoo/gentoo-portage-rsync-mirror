# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-3.0.3.ebuild,v 1.8 2012/05/05 03:20:39 jdhore Exp $

EAPI="2"

GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Drivel is a desktop blogger with support for LiveJournal, Blogger,
MoveableType, Wordpress and more."
HOMEPAGE="http://drivel.sourceforge.net/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="dbus spell"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"

RDEPEND=">=dev-libs/glib-2.16.6:2
	>=x11-libs/gtk+-2.16.5:2
	>=gnome-base/gconf-2:2
	>=gnome-base/gnome-vfs-2.6:2
	>=x11-libs/gtksourceview-2.2.2:2.0
	>=net-libs/libsoup-2.4.1:2.4
	>=dev-libs/libxml2-2.4.0:2
	spell? ( >=app-text/gtkspell-2.0.10:2 )
	dbus? ( >=dev-libs/dbus-glib-0.78 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.5"
DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_with spell gtkspell)
		$(use_with dbus)
		--disable-mime-update
		--disable-desktop-update
		--enable-error-on-warning=no
		--localstatedir=${D}/var"
}

src_prepare() {
	sed -i -e 's/make -C/$(MAKE) -C/' Makefile.am || die
	eautomake
}
