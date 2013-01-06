# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/luola/luola-1.3.0-r1.ebuild,v 1.4 2011/06/17 10:25:17 tupone Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="A 2D multiplayer arcade game resembling V-Wing"
HOMEPAGE="http://luolamies.org/software/luola/"
PATCH_SET="http://luolamies.org/software/luola/luola-1.3.0-1.patch
	http://luolamies.org/software/luola/luola-1.3.0-2.patch"
SRC_URI="http://luolamies.org/software/luola/${P}.tar.gz
	http://www.luolamies.org/software/luola/stdlevels-6.0.tar.gz
	http://www.luolamies.org/software/luola/nostalgia-1.2.tar.gz
	${PATCH_SET}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-gfx
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf"

src_prepare() {
	local p

	epatch "${FILESDIR}"/${P}-underlink.patch

	cd "${S}/src"
	for p in ${PATCH_SET}
	do
		epatch "${DISTDIR}/${p##*/}"
	done

	cd ..
	eautoreconf
}

src_configure() {
	egamesconf --enable-sound
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto "${GAMES_DATADIR}"/${PN}/levels
	doins "${WORKDIR}"/*.{lev,png} || die "doins failed"
	dodoc AUTHORS ChangeLog DATAFILE FAQ LEVELFILE README TODO \
		RELEASENOTES.txt ../README.Nostalgia
	newdoc ../README README.stdlevels
	doicon luola.png
	make_desktop_entry luola Luola
	prepgamesdirs
}
