# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/transcend/transcend-0.3.ebuild,v 1.7 2011/04/26 07:11:54 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="retro-style, abstract, 2D shooter"
HOMEPAGE="http://transcend.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Transcend_${PV}_UnixSource.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/libXmu
	x11-libs/libXi
	virtual/opengl
	virtual/glu
	media-libs/freeglut"

S=${WORKDIR}/Transcend_${PV}_UnixSource/Transcend

src_prepare() {
	chmod a+x portaudio/configure
	mkdir portaudio/{lib,bin}
	rm -f game/Makefile
	cat \
		Makefile.GnuLinuxX86 \
		Makefile.common \
		Makefile.minorGems \
		game/Makefile.all \
		Makefile.minorGems_targets \
		> game/Makefile
	sed -i \
		-e "s:\"levels\":\"${GAMES_DATADIR}/${PN}/levels\":" \
		game/LevelDirectoryManager.cpp \
		game/game.cpp \
		|| die "sed failed"
}

src_configure() {
	cd portaudio
	egamesconf || die
}

src_compile() {
	cd portaudio
	emake
	cd ../game
	emake || die
	cd ..
	cp game/Transcend ${PN} || die "cp failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels/ || die "doins failed"
	dodoc doc/how_to_*.txt
	prepgamesdirs
}
