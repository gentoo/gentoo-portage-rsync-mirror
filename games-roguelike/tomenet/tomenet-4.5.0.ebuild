# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/tomenet/tomenet-4.5.0.ebuild,v 1.1 2012/12/20 17:34:58 hasufell Exp $

EAPI=5
inherit eutils gnome2-utils games

DESCRIPTION="A MMORPG based on the works of J.R.R. Tolkien"
HOMEPAGE="http://www.tomenet.net/"
SRC_URI="http://www.tomenet.net/downloads/${P}.tar.bz2
	http://dev.gentoo.org/~hasufell/distfiles/${PN}4.png"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated server +sound"

# VERSION BUMP REMINDER:
# libX11 might be optional at next release
# via -DUSE_X11
DEPEND="sys-libs/ncurses
	x11-libs/libX11
	sound? (
		media-libs/libsdl[audio]
		media-libs/sdl-mixer[vorbis,smpeg,mp3]
	)"
RDEPEND="${DEPEND}
	sound? ( app-arch/p7zip[wxwidgets] )"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	rm -r ../lib/{data,save} || die

	sed \
		-e "s#@LIBDIR@#${GAMES_DATADIR}/${PN}#" \
		"${FILESDIR}"/${PN}-wrapper > "${T}"/${PN} || die
}

src_compile() {
	local mytargets="$(usex dedicated "accedit tomenet.server evilmeta" "$(usex server "all" "tomenet")")"
	emake \
		$(usex sound "USE_SDL=1" "") \
		-f makefile \
		"${mytargets[@]}"
}

src_install() {
	dodoc ../{ChangeLog,TomeNET-Guide.txt,changes.txt}

	if ! use dedicated ; then
		newgamesbin ${PN} ${PN}.bin
		dogamesbin "${T}"/${PN}

		doicon -s 48 "${DISTDIR}"/${PN}4.png
		make_desktop_entry ${PN} ${PN} ${PN}4
	fi

	if use server || use dedicated ; then
		dogamesbin accedit tomenet.server evilmeta
		docinto server
		dodoc runonce runserv runserv3
	fi

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ../lib/*
	doins ../.tomenetrc

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update

	if use server || use dedicated ; then
		elog "Server scripts in /usr/share/doc/${PF}/server will need adjustment."
		elog "\"lib\" dir is in ${GAMES_DATADIR}/${PN}"
	fi

	if use sound; then
		elog "You can get soundepacks from here:"
		elog '  http://www.tomenet.net/phpBB3/viewtopic.php?f=4&t=120'
		elog "They must be placed inside ~/.tomenet directory."
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
}
