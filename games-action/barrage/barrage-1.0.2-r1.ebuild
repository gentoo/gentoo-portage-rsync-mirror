# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/barrage/barrage-1.0.2-r1.ebuild,v 1.9 2011/10/02 13:47:20 armin76 Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A violent point-and-click shooting game"
HOMEPAGE="http://lgames.sourceforge.net"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz
	mirror://gentoo/${PN}.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2[audio,video]
	>=media-libs/sdl-mixer-1.2.4"

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	# bug #337745
	sed -i \
		-e 's/name\[20\]/name[24]/' \
		src/menu.h || die
}

src_configure() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README
	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Barrage
	rm "${D}"/usr/share/applications/${PN}.desktop
	prepgamesdirs
}
