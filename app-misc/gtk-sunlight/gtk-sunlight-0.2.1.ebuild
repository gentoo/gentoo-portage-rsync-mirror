# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtk-sunlight/gtk-sunlight-0.2.1.ebuild,v 1.2 2012/05/03 19:41:34 jdhore Exp $

EAPI=3

inherit eutils toolchain-funcs

DESCRIPTION="Real-time Sunlight Wallpaper"
HOMEPAGE="http://realtimesunlightwallpaper.weebly.com/"
SRC_URI="http://ppa.launchpad.net/realtime.sunlight.wallpaper/rsw/ubuntu/pool/main/g/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2"
DEPEND="${REPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${ED}" install || die
	dodoc README || die
}
