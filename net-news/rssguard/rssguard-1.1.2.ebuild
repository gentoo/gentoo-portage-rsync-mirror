# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rssguard/rssguard-1.1.2.ebuild,v 1.1 2012/10/29 12:21:42 yngwin Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="A tiny RSS and Atom feed reader"
HOMEPAGE="http://code.google.com/p/rss-guard/"
SRC_URI="http://rss-guard.googlecode.com/files/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus"

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4
	x11-themes/hicolor-icon-theme
	dbus? ( x11-libs/qt-dbus:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/rss-guard"
DOCS=( resources/text/AUTHORS resources/text/CHANGELOG )

src_prepare() {
	sed -e '/Encoding/d' -i resources/desktops/${PN}.desktop || die 'sed failed'
	epatch_user
}
