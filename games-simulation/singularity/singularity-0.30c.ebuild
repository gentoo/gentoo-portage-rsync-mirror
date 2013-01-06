# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/singularity/singularity-0.30c.ebuild,v 1.3 2011/08/07 03:11:59 phajdan.jr Exp $

EAPI=2
inherit eutils games

MUSIC=endgame-${PN}-music-006
DESCRIPTION="A simulation of a true AI. Go from computer to computer, pursued by the entire world"
HOMEPAGE="http://www.emhsoft.com/singularity/"
SRC_URI="http://endgame-singularity.googlecode.com/files/${P}-src.tar.gz
	music? ( http://endgame-singularity.googlecode.com/files/${MUSIC}.zip )"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+music"

RDEPEND="dev-python/pygame
	media-libs/sdl-mixer[vorbis]"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_prepare() {
	rm -f code/{,*}/*.pyc data/*.html # Remove unecessary files
}

src_install() {
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r code data ${PN}.py || die "doins failed"
	if use music ; then
		doins -r ../${MUSIC}/music || die "doins failed"
	fi
	games_make_wrapper ${PN} "python ${PN}.py" "${GAMES_DATADIR}/${PN}"
	dodoc README.txt TODO Changelog AUTHORS
	prepgamesdirs
}
