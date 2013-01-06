# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/simple-scan/simple-scan-3.6.0.ebuild,v 1.2 2012/12/20 05:29:52 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/3.6/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/glib-2.28:2
	>=media-gfx/sane-backends-1.0.20:=
	>=sys-libs/zlib-1.2.3.1:=
	virtual/jpeg:=
	virtual/udev:=[gudev]
	x11-libs/cairo:=
	>=x11-libs/gtk+-3:3
	|| (
		>=x11-misc/colord-0.1.24:=[udev]
		x11-misc/colord:=[scanner] )
"
RDEPEND="${COMMON_DEPEND}
	x11-misc/xdg-utils
	x11-themes/gnome-icon-theme
"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		VALAC=$(type -P true)
		ITSTOOL=$(type -P true)"
	gnome2_src_configure
}
