# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/transcend/transcend-0.3.ebuild,v 1.9 2015/02/06 08:47:53 mr_bones_ Exp $

EAPI=5
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
RDEPEND=${DEPEND}

S=${WORKDIR}/Transcend_${PV}_UnixSource/Transcend

src_prepare() {
	chmod a+x portaudio/configure
	mkdir portaudio/{lib,bin}
	rm -f game/Makefile
	sed \
		-e '/^GXX=/d' \
		-e 's/GXX/CXX/' \
		-e '/^COMPILE_FLAGS =/ s/OPTIMIZE_FLAG/CXXFLAGS/' \
		-e '/^EXE_LINK =/ s/LINK_FLAGS/LDFLAGS/' \
		Makefile.GnuLinuxX86 \
		Makefile.common \
		Makefile.minorGems \
		game/Makefile.all \
		Makefile.minorGems_targets \
		> game/Makefile || die
	sed -i \
		-e "s:\"levels\":\"${GAMES_DATADIR}/${PN}/levels\":" \
		game/LevelDirectoryManager.cpp \
		game/game.cpp || die
}

src_configure() {
	cd portaudio
	egamesconf
}

src_compile() {
	nonfatal emake -C portaudio
	emake -C game
	cp game/Transcend ${PN} || die
}

src_install() {
	dogamesbin ${PN}
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r levels/
	dodoc doc/{how_to_play.txt,changeLog.txt}
	prepgamesdirs
}
