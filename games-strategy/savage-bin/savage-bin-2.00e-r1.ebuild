# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/savage-bin/savage-bin-2.00e-r1.ebuild,v 1.3 2015/03/23 06:17:27 mr_bones_ Exp $

EAPI=5
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

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror bindist strip"

RDEPEND="
	|| (
		(
			>=media-libs/freetype-2.5.0.1[abi_x86_32(-)]
			>=media-libs/libsdl-1.2.15-r4[abi_x86_32(-)]
			>=virtual/jpeg-62:62[abi_x86_32(-)]
			>=virtual/opengl-7.0-r1[abi_x86_32(-)]
		)
		amd64? (
			(
				app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			)
		)
	)"
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
	doins -r *
	fperms g+x "${dir}"/silverback.bin
	dosym /dev/null "${dir}"/scripts.log

	dogamesbin "${T}"/savage
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
