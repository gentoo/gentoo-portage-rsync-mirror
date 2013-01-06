# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/garden/garden-1.0.8.ebuild,v 1.6 2011/06/22 16:24:25 tupone Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="Multiplatform vertical shoot-em-up with non-traditional elements"
HOMEPAGE="http://garden.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="<media-libs/allegro-5"

src_prepare() {
	epatch "${FILESDIR}"/${P}-underlink.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon resources/garden.svg
	make_desktop_entry garden "Garden of coloured lights"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
