# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-3.6.1.ebuild,v 1.2 2012/12/16 19:45:25 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GNOME hexadecimal editor"
HOMEPAGE="https://live.gnome.org/Ghex"

LICENSE="GPL-2+ FDL-1.1+"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=dev-libs/atk-1
	>=dev-libs/glib-2.31.10:2
	>=x11-libs/gtk+-3.3.8:3
"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.9.0
	>=dev-util/intltool-0.41.1
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_configure() {
	G2CONF="${G2CONF} --disable-static"
	gnome2_src_configure
}
