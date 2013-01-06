# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mlview/mlview-0.9.0-r1.ebuild,v 1.2 2012/05/03 18:33:00 jdhore Exp $

EAPI=2

GNOME2_LA_PUNT=yes
inherit autotools eutils gnome2

DESCRIPTION="XML editor for the GNOME environment"
HOMEPAGE="http://www.freespiders.org/projects/gmlview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=dev-libs/libxml2-2.6.11:2
	>=dev-libs/libxslt-1.1.8
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.6:2
	>=dev-cpp/gtkmm-2.4:2.4
	>=gnome-base/libglade-2.4:2.0
	>=dev-cpp/libglademm-2.6:2.4
	>=gnome-base/libgnome-2.8.1
	>=gnome-base/gnome-vfs-2.6:2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/gconf-2.6.2:2
	x11-libs/gtksourceview:2.0
	>=x11-libs/vte-0.11.12:0
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS BRANCHES ChangeLog NEWS README"
	G2CONF="--disable-dependency-tracking
		--disable-static
		$(use_enable debug)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-desktop.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
	epatch "${FILESDIR}"/${P}-gcc45.patch
	epatch "${FILESDIR}"/${PF}-10_port_to_gtksourceview2.patch
	epatch "${FILESDIR}"/${PF}-autoreconf.patch
	mkdir m4 || die
	eautoreconf
	intltoolize --force
	gnome2_src_prepare
}
