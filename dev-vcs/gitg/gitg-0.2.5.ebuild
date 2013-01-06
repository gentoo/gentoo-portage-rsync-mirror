# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitg/gitg-0.2.5.ebuild,v 1.4 2012/06/09 14:29:42 sping Exp $

EAPI="3"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="git repository viewer for GNOME"
HOMEPAGE="http://git.gnome.org/browse/gitg/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
# FIXME: debug changes CFLAGS
IUSE="debug glade"

RDEPEND=">=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-3.0.0:3
	>=x11-libs/gtksourceview-3.1.3:3.0
	>=gnome-base/gconf-2.10:2
	>=gnome-base/gsettings-desktop-schemas-0.1.1
	dev-vcs/git
	glade? ( >=dev-util/glade-3.2:3.10 )
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	>=dev-util/intltool-0.40"

pkg_setup() {
	# Disable maintainer to get rid of -Werror  (bug #363009)
	G2CONF="${G2CONF}
		--disable-static
		--disable-deprecations
		--disable-dependency-tracking
		--disable-maintainer-mode
		$(use_enable debug)
		$(use_enable glade glade-catalog)"

	DOCS="AUTHORS ChangeLog NEWS README"
}

src_test() {
	emake check || die
}
