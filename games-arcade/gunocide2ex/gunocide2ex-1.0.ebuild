# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/gunocide2ex/gunocide2ex-1.0.ebuild,v 1.15 2012/02/05 06:20:50 vapier Exp $

EAPI=2
inherit eutils unpacker toolchain-funcs games

DESCRIPTION="fast-paced 2D shoot'em'up"
HOMEPAGE="http://www.polyfrag.com/content/product_gunocide.html"
SRC_URI="mirror://sourceforge/g2ex/g2ex-setup.run"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl[video]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
	mkdir binary
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch
	edos2unix config.cfg
	sed -i \
		-e "s:/usr/local/games/gunocide2ex/config\.cfg:${GAMES_SYSCONFDIR}/${PN}.cfg:" \
		-e "s:/usr/local/games/gunocide2ex/hscore\.dat:${GAMES_STATEDIR}/${PN}-hscore.dat:" \
		-e "s:memleaks.log:/dev/null:" \
		src/*.{h,cpp} \
		|| die "sed failed"
	sed -i \
		-e "s:/usr/local/games:${GAMES_DATADIR}:" \
		src/*.{h,cpp} $(find gfx -name '*.txt') \
		|| die "sed failed"
}

src_compile() {
	cd src
	emake CXXFLAGS="$CXXFLAGS $(sdl-config --cflags)" $(echo *.cpp | sed 's/\.cpp/.o/g') \
		|| die "emake failed"
	$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -o ${PN} *.o -lpthread -lSDL -lSDL_ttf -lSDL_mixer \
		|| die "cxx failed"
}

src_install() {
	dogamesbin src/${PN}               || die "dogamesbin failed"
	dosym ${PN} "${GAMES_BINDIR}/g2ex" || die "dosym failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r gfx sfx lvl credits arial.ttf || die "doins failed"
	insinto "${GAMES_SYSCONFDIR}"
	newins config.cfg ${PN}.cfg        || die "newins failed (cfg)"
	insinto "${GAMES_STATEDIR}"
	newins hscore.dat ${PN}-hscore.dat || die "newins failed (hscore)"
	dodoc history doc/MANUAL_DE        || die "dodoc failed"
	dohtml doc/manual_de.html          || die "dohtml failed"
	newicon g2icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Gunocide II EX"
	prepgamesdirs
}
