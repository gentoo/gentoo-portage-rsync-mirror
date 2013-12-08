# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-3.0.5.ebuild,v 1.3 2013/12/08 19:28:53 pacho Exp $

EAPI=5
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Desktop blogger with support for LiveJournal, Blogger and more"
HOMEPAGE="http://drivel.sourceforge.net/"
SRC_URI="mirror://sourceforge/drivel/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE="dbus spell"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="
	>=dev-libs/glib-2.16.6:2
	>=x11-libs/gtk+-2.16.5:2
	>=gnome-base/gconf-2:2
	>=gnome-base/gnome-vfs-2.6:2
	>=x11-libs/gtksourceview-2.2.2:2.0
	>=net-libs/libsoup-2.4.1:2.4
	>=dev-libs/libxml2-2.4.0:2
	spell? ( >=app-text/gtkspell-2.0.10:2 )
	dbus? ( >=dev-libs/dbus-glib-0.78 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/intltool-0.21
	>=app-text/scrollkeeper-0.3.5
"

src_prepare() {
	sed -i -e 's/make -C/$(MAKE) -C/' Makefile.am || die
	sed -i -e 's/ -Werror//' configure.ac || die

	# https://bugzilla.gnome.org/show_bug.cgi?id=704974
	sed -i \
		-e 's/drivel-48.png/drivel-48/' \
		-e 's/x-drivel/x-drivel;/' \
		-e 's/Application;//' data/gnome-drivel.desktop.in || die

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		$(use_with spell gtkspell) \
		$(use_with dbus) \
		--disable-mime-update \
		--disable-desktop-update \
		--localstatedir="${D}"/var
}
