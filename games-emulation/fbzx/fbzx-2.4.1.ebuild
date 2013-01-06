# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fbzx/fbzx-2.4.1.ebuild,v 1.4 2012/05/04 04:38:38 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A Sinclair Spectrum emulator, designed to work at full screen using the FrameBuffer"
HOMEPAGE="http://www.rastersoft.com/fbzx.html"
SRC_URI="http://www.rastersoft.com/descargas/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl[video]
	media-sound/pulseaudio
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "s|/usr/share/|${GAMES_DATADIR}/${PN}/|g" \
		emulator.c \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-build.patch
	rm -f fbzx_fs fbzx *.o # clean out accidentally packaged .o files
}

src_install() {
	dogamesbin fbzx || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r keymap.bmp spectrum-roms || die "doins failed"
	dodoc AMSTRAD CAPABILITIES FAQ PORTING README* TODO VERSIONS
	doicon fbzx.svg
	make_desktop_entry fbzx FBZX
	prepgamesdirs
}
