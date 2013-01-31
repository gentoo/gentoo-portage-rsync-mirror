# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/dosbox/dosbox-9999.ebuild,v 1.4 2013/01/31 20:17:21 mr_bones_ Exp $

EAPI=2
ESVN_REPO_URI="https://dosbox.svn.sourceforge.net/svnroot/dosbox/dosbox/trunk"
inherit autotools eutils subversion games

DESCRIPTION="DOS emulator"
HOMEPAGE="http://dosbox.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="alsa debug hardened opengl"

DEPEND="alsa? ( media-libs/alsa-lib
		media-libs/libsdl[alsa] )
	opengl? (
		virtual/glu
		virtual/opengl )
	debug? ( sys-libs/ncurses )
	media-libs/libpng
	media-libs/libsdl[joystick,video]
	media-libs/sdl-net
	media-libs/sdl-sound"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	subversion_src_prepare
	eautoreconf
}

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		$(use_enable alsa alsa-midi) \
		$(use_enable !hardened dynamic-core) \
		$(use_enable !hardened dynamic-x86) \
		$(use_enable debug) \
		$(use_enable opengl)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS
	make_desktop_entry dosbox DOSBox /usr/share/pixmaps/dosbox.ico
	doicon src/dosbox.ico
	prepgamesdirs
}
