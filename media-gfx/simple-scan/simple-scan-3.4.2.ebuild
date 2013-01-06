# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/simple-scan/simple-scan-3.4.2.ebuild,v 1.5 2012/12/20 05:29:52 tetromino Exp $

EAPI="4"

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Simple document scanning utility"
HOMEPAGE="https://launchpad.net/simple-scan"
SRC_URI="http://launchpad.net/${PN}/3.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND="
	>=dev-libs/glib-2.28:2
	>=media-gfx/sane-backends-1.0.20
	virtual/jpeg
	virtual/udev[gudev]
	>=sys-libs/zlib-1.2.3.1
	x11-libs/cairo
	>=x11-libs/gtk+-3:3
	|| (
		>=x11-misc/colord-0.1.24[udev]
		x11-misc/colord[scanner] )
"
RDEPEND="${COMMON_DEPEND}
	x11-misc/xdg-utils
	x11-themes/gnome-icon-theme"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	dev-lang/vala:0.14
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} VALAC=$(type -p valac-0.14)"
}
