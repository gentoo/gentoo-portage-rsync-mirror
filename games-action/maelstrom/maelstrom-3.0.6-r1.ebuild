# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/maelstrom/maelstrom-3.0.6-r1.ebuild,v 1.12 2014/05/15 16:23:38 ulm Exp $

EAPI=2
inherit eutils games

MY_P=Maelstrom-${PV}
DESCRIPTION="An asteroids battle game"
SRC_URI="http://www.devolution.com/~slouken/Maelstrom/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/Maelstrom/"

KEYWORDS="alpha amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="media-libs/libsdl[sound,joystick,video]
	media-libs/sdl-net"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PF}-security.patch \
		"${FILESDIR}"/${P}-64bits.patch \
		"${FILESDIR}"/${PN}-gcc34.patch

	# Install the data into $(datadir)/..., not $(prefix)/games/...
	sed -i \
		-e "s:(prefix)/games/:(datadir)/:" configure \
		|| die "sed failed"
	sed -i \
		-e '/make install_gamedata/s:=:=$(DESTDIR)/:' \
		Makefile.in \
		|| die "sed failed"
	# Install the high scores file in ${GAMES_STATEDIR}
	sed -i \
		-e "s:path.Path(MAELSTROM_SCORES):\"${GAMES_STATEDIR}/\"MAELSTROM_SCORES:" \
		scores.cpp \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc Changelog README* Docs/{Maelstrom-Announce,*FAQ,MaelstromGPL_press_release,*.Paper,Technical_Notes*}
	newicon "${D}${GAMES_DATADIR}"/Maelstrom/icon.xpm maelstrom.xpm
	make_desktop_entry Maelstrom "Maelstrom" maelstrom

	# Put the high scores file in the right place
	insinto "${GAMES_STATEDIR}"
	doins "${D}${GAMES_DATADIR}"/Maelstrom/Maelstrom-Scores || die "doins failed"
	# clean up some cruft
	rm -f \
		"${D}${GAMES_DATADIR}"/Maelstrom/Maelstrom-Scores \
		"${D}${GAMES_DATADIR}"/Maelstrom/Images/Makefile*
	# make sure we can update the high scores
	fperms 664 "${GAMES_STATEDIR}"/Maelstrom-Scores || die "fperms failed"
	prepgamesdirs
}
