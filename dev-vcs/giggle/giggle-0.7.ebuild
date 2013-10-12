# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/giggle/giggle-0.7.ebuild,v 1.1 2013/10/12 14:35:35 ikelos Exp $

EAPI="5"

inherit gnome2 eutils

DESCRIPTION="GTK+ Frontend for GIT"
HOMEPAGE="http://live.gnome.org/giggle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="eds"

RDEPEND=">=dev-vcs/git-1.5
		 >=dev-libs/glib-2.30:2
		 >=x11-libs/gtk+-3.3.12:3
		 >=x11-libs/gtksourceview-3.0:3.0
		 >=x11-libs/gdk-pixbuf-2.22.0
		 gnome-base/gnome-common
		 eds? ( <gnome-extra/evolution-data-server-3.6 )
		 >=x11-libs/vte-0.28:2.90"
DEPEND="${RDEPEND}
		sys-devel/gettext
		app-text/yelp-tools
		virtual/pkgconfig
		>=dev-util/intltool-0.35
		>=sys-devel/autoconf-2.64
		>=sys-devel/libtool-2"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="$(use_enable eds evolution-data-server)"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.6.2-gtksourceview-3.8.0.patch"
}
