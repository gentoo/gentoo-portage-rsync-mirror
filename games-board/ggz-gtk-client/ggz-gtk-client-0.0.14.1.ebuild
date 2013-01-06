# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.14.1.ebuild,v 1.9 2012/05/04 04:30:10 jdhore Exp $

EAPI=2
inherit eutils autotools games-ggz

DESCRIPTION="The GTK+ client for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="debug"

RDEPEND="~dev-games/libggz-${PV}
	~dev-games/ggz-client-libs-${PV}
	x11-libs/gtk+:2
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlink.patch
	eautoreconf
}

src_compile() {
	games-ggz_src_compile \
		--disable-gaim-plugin
}
