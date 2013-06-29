# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/singularity/singularity-0.30c.ebuild,v 1.6 2013/06/29 17:00:40 slyfox Exp $

EAPI=2
inherit eutils games

MUSIC=endgame-${PN}-music-006
DESCRIPTION="A simulation of a true AI. Go from computer to computer, pursued by the entire world"
HOMEPAGE="http://www.emhsoft.com/singularity/"
SRC_URI="http://endgame-singularity.googlecode.com/files/${P}-src.tar.gz
	music? ( http://endgame-singularity.googlecode.com/files/${MUSIC}.zip )"

LICENSE="GPL-2 CC-BY-SA-2.5"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+music"

RDEPEND="=dev-lang/python-2*
	dev-python/pygame
	dev-python/numpy
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
	# uses python-2 style exceptions
	games_make_wrapper ${PN} "python2 ${PN}.py" "${GAMES_DATADIR}/${PN}"
	dodoc README.txt TODO Changelog AUTHORS
	prepgamesdirs
}
