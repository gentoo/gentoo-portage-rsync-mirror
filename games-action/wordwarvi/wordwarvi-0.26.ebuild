# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/wordwarvi/wordwarvi-0.26.ebuild,v 1.4 2012/05/03 03:02:34 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A retro side-scrolling shoot'em up based on the editor war story"
HOMEPAGE="http://wordwarvi.sourceforge.net"
SRC_URI="mirror://sourceforge/wordwarvi/${P}.tar.gz"

LICENSE="GPL-2 CCPL-Attribution-2.0 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="vorbis"

RDEPEND="x11-libs/gtk+:2
	vorbis? ( media-libs/libvorbis
		>=media-libs/portaudio-19_pre1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-sound.patch
	sed -i \
		-e "/^WITHAUDIO/s/yes/$(use vorbis && echo yes || echo no)/" \
		Makefile \
		|| die "sed failed"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		wwviaudio.c \
		|| die "sed failed"
}

src_compile() {
	emake \
		PREFIX="${GAMES_PREFIX}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		MANDIR="/usr/share/man" \
		|| die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PREFIX="${GAMES_PREFIX}" \
		DATADIR="${GAMES_DATADIR}/${PN}" \
		MANDIR="/usr/share/man" \
		install || die "emake install failed"
	use vorbis || rm -rf "${D}${GAMES_DATADIR}/${PN}"
	dodoc README AUTHORS changelog.txt AAA_HOW_TO_MAKE_NEW_LEVELS.txt
	newicon icons/wordwarvi_icon_128x128.png ${PN}.png
	make_desktop_entry ${PN} "Word War vi"
	prepgamesdirs
}
