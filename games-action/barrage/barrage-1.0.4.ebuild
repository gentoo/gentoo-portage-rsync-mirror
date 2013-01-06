# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/barrage/barrage-1.0.4.ebuild,v 1.5 2012/01/10 20:36:24 ranger Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A violent point-and-click shooting game"
HOMEPAGE="http://lgames.sourceforge.net"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2[audio,video]
	>=media-libs/sdl-mixer-1.2.4"

src_configure() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README
	newicon barrage48.png ${PN}.png
	make_desktop_entry ${PN} Barrage
	rm "${D}"/usr/share/applications/${PN}.desktop
	prepgamesdirs
}
