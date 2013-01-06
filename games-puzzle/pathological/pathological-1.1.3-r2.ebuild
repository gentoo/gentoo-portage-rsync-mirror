# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pathological/pathological-1.1.3-r2.ebuild,v 1.10 2012/09/04 22:05:37 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="An enriched clone of the game 'Logical' by Rainbow Arts"
HOMEPAGE="http://pathological.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="doc"

DEPEND="doc? ( media-libs/netpbm )"
RDEPEND=">=dev-python/pygame-1.5.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./${PN}.6.gz
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-music-py.patch

	if use doc ; then
		sed -i -e '5,$ s/=/ /g' makehtml || die
	else
		echo "#!/bin/sh" > makehtml
	fi

	sed -i \
		-e "s:/usr/share/games:${GAMES_DATADIR}:" \
		-e "s:/var/games:${GAMES_STATEDIR}:" \
		-e "s:exec:exec python:" \
		${PN} || die

	sed -i \
		-e 's:\xa9:(C):' \
		-e "s:/usr/lib/${PN}/bin:$(games_get_libdir)/${PN}:" \
		${PN}.py || die
}

src_install() {
	dogamesbin ${PN} || die

	exeinto "$(games_get_libdir)"/${PN}
	doexe write-highscores || die

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r circuits graphics music sounds ${PN}.py || die

	insinto "${GAMES_STATEDIR}"
	doins ${PN}_scores || die
	fperms 660 "${GAMES_STATEDIR}"/${PN}_scores

	dodoc changelog README TODO
	doman ${PN}.6
	use doc && dohtml -r html/*

	doicon ${PN}.xpm
	make_desktop_entry ${PN} Pathological ${PN}

	# remove some unneeded resource files
	rm -f "${D}/${GAMES_DATADIR}"/${PN}/graphics/*.xcf
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! has_version "media-libs/sdl-mixer[mod]" ; then
		echo
		elog "Since you have turned off the 'mod' use flag for media-libs/sdl-mixer"
		elog "no background music will be played."
		echo
	fi

}
