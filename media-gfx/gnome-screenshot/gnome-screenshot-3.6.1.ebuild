# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gnome-screenshot/gnome-screenshot-3.6.1.ebuild,v 1.1 2012/12/23 23:03:36 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Screenshot utility for GNOME 3"
HOMEPAGE="https://live.gnome.org/GnomeUtils"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

# libcanberra 0.26-r2 is needed for gtk+:3 fixes
COMMON_DEPEND="
	>=dev-libs/glib-2.33.1:2
	>=media-libs/libcanberra-0.26-r2[gtk3]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-3.0.3:3
	x11-libs/libX11
	x11-libs/libXext
"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gsettings-desktop-schemas-0.1.0
	!<gnome-extra/gnome-utils-3.4
"
# ${PN} was part of gnome-utils before 3.4
DEPEND="${COMMON_DEPEND}
	x11-proto/xextproto
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

pkg_postinst() {
	gnome2_pkg_postinst

	elog "${P} saves screenshots in ~/Pictures/ and defaults to"
	elog "non-interactive mode when launched from a terminal. If you want to choose"
	elog "where to save the screenshot, run"
	elog " $ gnome-screenshot --interactive"
}
