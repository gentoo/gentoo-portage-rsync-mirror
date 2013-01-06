# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xvattr/xvattr-1.3-r2.ebuild,v 1.7 2012/05/05 08:58:56 jdhore Exp $

EAPI=1

inherit eutils autotools

DESCRIPTION="X11 XVideo Querying/Setting Tool from Ogle project"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 ppc x86"
IUSE="gtk"

RDEPEND="x11-libs/libX11
	x11-libs/libXv
	x11-libs/libXext
	gtk? ( x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	x11-libs/libXt
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtk.patch
	eautoreconf
}

src_compile() {
	econf $(use_with gtk)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
