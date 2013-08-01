# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage-bin/savage-bin-2.00e.ebuild,v 1.15 2013/08/01 20:55:44 ssuominen Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Unique mix of strategy and FPS"
HOMEPAGE="http://www.s2games.com/savage/
	http://www.notforidiots.com/SFE/
	http://www.newerth.com/"
SRC_URI="http://www.newerth.com/?id=downloads&op=downloadFile&file=SFE-Standalone.tar.gz&mirrorid=1 -> SFE-Standalone.tar.gz
	http://www.newerth.com/?id=downloads&op=downloadFile&file=SFE-Standalone.tar.gz&mirrorid=2 -> SFE-Standalone.tar.gz
	http://www.newerth.com/?id=downloads&op=downloadFile&file=SFE-Standalone.tar.gz&mirrorid=3 -> SFE-Standalone.tar.gz
	http://www.newerth.com/?id=downloads&op=downloadFile&file=lin-client-auth-patch.zip&mirrorid=1 -> lin-client-auth-patch.zip
	http://www.newerth.com/?id=downloads&op=downloadFile&file=lin-client-auth-patch.zip&mirrorid=2 -> lin-client-auth-patch.zip
	http://www.newerth.com/?id=downloads&op=downloadFile&file=lin-client-auth-patch.zip&mirrorid=3 -> lin-client-auth-patch.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	x86? ( media-libs/libsdl
		>=media-libs/freetype-2
		|| ( virtual/jpeg:62 media-libs/jpeg:62 ) )
	amd64? ( app-emulation/emul-linux-x86-sdl )"
DEPEND="app-arch/unzip"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/savage

QA_TEXTRELS="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so
	${dir:1}/game/game.so"
QA_EXECSTACK="${dir:1}/libs/libfmod.so
	${dir:1}/libs/libfmod-3.75.so"

src_prepare() {
	cp -f lin-client-auth-patch/silverback.bin .
	cp -f lin-client-auth-patch/game/game.so game/.
	cp -f lin-client-auth-patch/libs/libpng12.so.0 libs/.
	rm -rf lin-client-auth-patch/
	rm -f graveyard/game.dll *.sh
	sed -e "s:%GAMES_PREFIX_OPT%:${GAMES_PREFIX_OPT}:" \
		-e 's/^exec /__GL_ExtensionStringVersion=17700 exec /' \
		"${FILESDIR}"/savage > "${T}"/savage || die
	# Here, we default to the best resolution
	sed -i \
		-e 's/setsave vid_mode -1/setsave vid_mode 1/' \
		game/settings/default.cfg || die
}

src_install() {
	insinto "${dir}"
	doins -r * || die "doins failed"
	fperms g+x "${dir}"/silverback.bin || die "fperms failed"
	dosym /dev/null "${dir}"/scripts.log || die "dosym failed"

	dogamesbin "${T}"/savage || die
	make_desktop_entry savage "Savage: The Battle For Newerth"

	games_make_wrapper savage-graveyard "./silverback.bin set mod graveyard" \
		"${dir}" "${dir}"/libs
	sed -i \
		-e 's/^exec /__GL_ExtensionStringVersion=17700 exec /' \
		"${D}/${GAMES_BINDIR}/savage-graveyard" || die
	make_desktop_entry savage-graveyard "Savage: Graveyard"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "In order to play \"Savage: The Battle For Newerth\", use:"
	elog "savage"
	elog "In order to start Editor, use:"
	elog "savage-graveyard"
}
