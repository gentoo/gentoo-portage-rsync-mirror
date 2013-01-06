# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gnome-dictionary/gnome-dictionary-3.4.0.ebuild,v 1.2 2012/12/16 19:29:28 tetromino Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Dictionary utility for GNOME 3"
HOMEPAGE="https://live.gnome.org/GnomeUtils"

LICENSE="GPL-2+ LGPL-2.1+ FDL-1.1+"
SLOT="0"
IUSE="doc ipv6"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

COMMON_DEPEND=">=dev-libs/glib-2.28.0:2
	x11-libs/cairo
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
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.15 )"

pkg_setup() {
	DOCS="AUTHORS NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-schemas-compile
		$(use_enable ipv6)"
}
