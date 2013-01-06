# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rodent/rodent-4.8.0.ebuild,v 1.4 2012/11/28 12:32:59 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="A fast, small and powerful file manager and graphical shell"
HOMEPAGE="http://rodent.xffm.org/"
SRC_URI="mirror://sourceforge/xffm/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="experimental"

COMMON_DEPEND="x11-libs/libX11
	x11-libs/libSM
	dev-libs/libxml2
	>=dev-libs/glib-2.24
	x11-libs/gtk+:3
	>=x11-libs/cairo-1.8.10
	>=gnome-base/librsvg-2.26
	>=dev-libs/libzip-0.9
	sys-apps/file"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=( $(use_with experimental) )
	DOCS=( ChangeLog README TODO )
}

src_install() {
	# Build/share/Makefile.am:docdir = $(datadir)/doc/@PLUGIN_DIR@
	xfconf_src_install docdir=/usr/share/doc/${PF}
}
