# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/cs2d/cs2d-0120-r1.ebuild,v 1.1 2012/05/30 09:04:20 maksbotan Exp $

EAPI=2

inherit eutils games

DESCRIPTION="Counter-Strike 2D is freeware clone of Counter-Strike with some added features in gameplay."
HOMEPAGE="http://www.cs2d.com/"
SRC_URI="http://dev.gentoo.org/~maksbotan/cs2d/cs2d_${PV}_linux.zip
	http://dev.gentoo.org/~maksbotan/cs2d/cs2d_${PV}_win.zip
	http://dev.gentoo.org/~maksbotan/cs2d/cs2d.png"
LICENSE="freedist"

SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="
	x86? (
		media-libs/openal
		media-libs/freetype:2
		x11-libs/libX11
		x11-libs/libXxf86vm
		virtual/opengl
	)
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-xlibs
	)"

QA_PRESTRIPPED="opt/cs2d/CounterStrike2D"
QA_EXECSTACK="opt/cs2d/CounterStrike2D"

S=${WORKDIR}

src_prepare() {
	# removing windows files
	rm -f *.exe *.bat

	# OpenAL is default sound driver
	sed -i -e 's:^sounddriver.*$:sounddriver OpenAL Default:' sys/config.cfg || die
}

src_install() {
	insinto "${GAMES_PREFIX_OPT}"/${PN}
	doins -r . || die

	make_desktop_entry CounterStrike2D "Counter Strike 2D"
	make_desktop_entry "CounterStrike2D -fullscreen -24bit" "Counter Strike 2D - FULLSCREEN"
	games_make_wrapper CounterStrike2D ./CounterStrike2D \
		"${GAMES_PREFIX_OPT}"/${PN} "${GAMES_PREFIX_OPT}"/${PN}

	doicon "${DISTDIR}"/${PN}.png

	prepgamesdirs

	# fixing permissions
	fperms -R g+w "${GAMES_PREFIX_OPT}"/${PN}/maps
	fperms -R g+w "${GAMES_PREFIX_OPT}"/${PN}/screens
	fperms -R g+w "${GAMES_PREFIX_OPT}"/${PN}/sys
	fperms ug+x "${GAMES_PREFIX_OPT}"/${PN}/CounterStrike2D
}
