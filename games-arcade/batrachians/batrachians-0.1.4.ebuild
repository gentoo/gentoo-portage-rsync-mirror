# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/batrachians/batrachians-0.1.4.ebuild,v 1.4 2012/05/04 04:22:28 jdhore Exp $

EAPI=2
inherit autotools games

DESCRIPTION="A fly-eating frog video game"
HOMEPAGE="http://perso.b2b2c.ca/sarrazip/dev/batrachians.html"
SRC_URI="http://perso.b2b2c.ca/sarrazip/dev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=dev-games/flatzebra-0.1.5"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "/^pkgsounddir/ s:sounds.*:\$(PACKAGE)/sounds:" \
		-e "/^desktopentrydir/ s:=.*:=/usr/share/applications:" \
		-e "/^pixmapdir/ s:=.*:=/usr/share/pixmaps:" \
		src/Makefile.am \
		|| die "sed failed"
	eautoreconf
}

src_install() {
	emake -C src DESTDIR="${D}" install || die "emake install failed"
	doman doc/${PN}.6
	dodoc AUTHORS NEWS README THANKS
	prepgamesdirs
}
