# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/giggle/giggle-0.6.1.ebuild,v 1.9 2012/12/29 17:21:42 ikelos Exp $

EAPI="3"

inherit gnome2 autotools eutils

DESCRIPTION="GTK+ Frontend for GIT"
HOMEPAGE="http://live.gnome.org/giggle"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="eds"

RDEPEND=">=dev-vcs/git-1.5
		 >=dev-libs/glib-2.18:2
		 >=x11-libs/gtk+-3.0:3
		 >=x11-libs/gtksourceview-3.0:3.0
		 gnome-base/gnome-common
		 eds? ( <gnome-extra/evolution-data-server-3.6 )
		 >=x11-libs/vte-0.26:2.90"
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
	epatch "${FILESDIR}/${P}-gmodule-explicit.patch"
	eautoreconf
}
