# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-font-viewer/gnome-font-viewer-3.4.0.ebuild,v 1.2 2012/10/22 18:03:27 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Font viewer for GNOME 3"
HOMEPAGE="https://live.gnome.org/GnomeUtils"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

COMMON_DEPEND=">=dev-libs/glib-2.31.0:2
	media-libs/freetype:2
	x11-libs/cairo
	>=x11-libs/gtk+-3.0.3:3
	x11-libs/pango"
RDEPEND="${COMMON_DEPEND}
	!<gnome-base/gnome-control-center-2.91
	!<gnome-extra/gnome-utils-3.4"
# ${PN} was part of gnome-utils before 3.4, and of g-c-c before 2.91
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"

pkg_setup() {
	DOCS="NEWS"
	G2CONF="${G2CONF} --disable-schemas-compile"
}
