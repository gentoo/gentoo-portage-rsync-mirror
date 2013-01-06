# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmfire/wmfire-1.2.4-r1.ebuild,v 1.6 2012/07/29 18:37:19 armin76 Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Load monitoring dockapp displaying dancing flame."
HOMEPAGE="http://www.swanson.ukfsn.org/#wmfire"
SRC_URI="http://www.swanson.ukfsn.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="session"

RDEPEND="x11-libs/gtk+:2
	gnome-base/libgtop:2
	x11-libs/libX11
	x11-libs/libXext
	session? ( x11-libs/libSM
		x11-libs/libICE )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.3-stringh.patch
	epatch "${FILESDIR}"/${P}-no_display.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable session)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ALL_I_GET_IS_A_GREY_BOX AUTHORS ChangeLog NEWS README
}
