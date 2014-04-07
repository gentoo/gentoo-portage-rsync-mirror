# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmlife/wmlife-1.0.0.ebuild,v 1.5 2014/04/07 19:40:20 ssuominen Exp $

EAPI=5
inherit eutils

DESCRIPTION="dockapp running Conway's Game of Life (and program launcher)."
HOMEPAGE="http://www.swanson.ukfsn.org/#wmlife"
SRC_URI="http://www.swanson.ukfsn.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/gnome-panel-2
	>=gnome-base/libgnomeui-2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXt"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-stringh.patch
}

src_configure() {
	econf --enable-session
}
