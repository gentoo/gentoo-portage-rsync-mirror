# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darksnow/darksnow-0.6.1.ebuild,v 1.8 2012/05/05 08:20:55 mgorny Exp $

EAPI=2

inherit eutils gnome2-utils

DESCRIPTION="Streaming GTK+ Front-End based in Darkice Ice Streamer"
HOMEPAGE="http://darksnow.radiolivre.org"
SRC_URI="http://darksnow.radiolivre.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

PDEPEND=">=media-sound/darkice-0.14"
RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc documentation/{CHANGES,CREDITS,README*}
	make_desktop_entry ${PN} "DarkSnow" ${PN}
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
