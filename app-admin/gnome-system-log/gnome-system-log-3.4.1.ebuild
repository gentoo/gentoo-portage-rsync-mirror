# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gnome-system-log/gnome-system-log-3.4.1.ebuild,v 1.2 2012/12/16 18:57:02 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="System log viewer for GNOME 3"
HOMEPAGE="https://live.gnome.org/GnomeUtils"

LICENSE="GPL-2+ FDL-1.1+"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

COMMON_DEPEND=">=dev-libs/glib-2.31.0:2
	sys-libs/zlib
	>=x11-libs/gtk+-3.0.0:3
	x11-libs/pango"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas
	!<gnome-extra/gnome-utils-3.4"
# ${PN} was part of gnome-utils before 3.4
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17
	virtual/pkgconfig"

pkg_setup() {
	DOCS="NEWS TODO"
	G2CONF="${G2CONF}
		--disable-schemas-compile
		--enable-zlib"
}
