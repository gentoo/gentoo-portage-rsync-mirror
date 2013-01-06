# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gargoyle/gargoyle-2010.1.ebuild,v 1.2 2012/09/05 07:44:50 jlec Exp $

EAPI=2

# Notes:
#  - fmod support is based on an old version of fmod which is not in portage,
#    and therefore not supported by this ebuild. SDL is the preferred library.
#  - Have contacted upstream requesting overridable build variables and a
#    configurable config file path, to obviate file editing in src_prepare.

# Regarding licenses: libgarglk is licensed under the GPLv2. Bundled
# interpreters are licensed under GPLv2, BSD or MIT license, except:
#   - alan2/alan3: status unclear!
#   - glulxe: custom license, see "terps/glulxle/README"
#   - hugo: custom license, see "licenses/HUGO License.txt"
# Since we don't compile or install any of the bundled fonts, their licenses
# don't apply. (Fonts are installed through dependencies instead.)

inherit eutils games

DESCRIPTION="An interactive fiction (IF) player supporting all major formats"
HOMEPAGE="http://ccxvii.net/gargoyle/"
SRC_URI="http://garglk.googlecode.com/files/${P}-sources.zip"

LICENSE="BSD GPL-2 MIT Hugo Glulxe"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="sdl"

RDEPEND="media-libs/freetype:2
	virtual/jpeg
	media-libs/libpng
	media-fonts/liberation-fonts
	media-fonts/libertine-ttf
	sys-libs/zlib
	x11-libs/gtk+:2
	sdl? (
		media-libs/libsdl
		media-libs/sdl-mixer
		media-libs/sdl-sound
		media-libs/libvorbis
		media-libs/smpeg
	)"

DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/ftjam"

src_prepare() {
	if ! use sdl; then
		sed -i -e '/^USESDL = /s/yes/no/' Jamrules || die
	fi

	# Substitute custom CFLAGS/LDFLAGS:
	sed -i -e \
		"/^\s*OPTIM = / {
			s/ \(-O.*\)\? ;/ ${CFLAGS} ;/
			a LINKFLAGS = ${LDFLAGS} ;
			a SHRLINKFLAGS = ${LDFLAGS} ;
		}" Jamrules || die

	# Don't bundle default fonts; we'll install better ones as a dependency:
	sed -i -e '/^BUNDLEFONTS = /s/yes/no/' Jamrules || die

	# Convert garglk.ini to UNIX format:
	edos2unix garglk/garglk.ini

	# Fix path to garglk.ini in config loader:
	sed -i -e "s|/etc|${GAMES_SYSCONFDIR}|" garglk/config.c || die
}

src_compile() {
	jam || die
	jam install || die
	# Note: the line above doesn't actually install anything yet!
}

src_install() {
	# Install config file:
	insinto "${GAMES_SYSCONFDIR}"
	newins garglk/garglk.ini garglk.ini || die

	# Install application entry and icon:
	domenu garglk/${PN}.desktop || die
	doicon garglk/${PN}-house.png || die

	# Install library:
	cd build/dist || die
	dogameslib libgarglk.so || die

	# Install launcher and terps, symlinking binaries to avoid name clashes:
	insinto "${GAMES_PREFIX}/libexec/${PN}"
	insopts -m0755
	for terp in advsys agility alan2 alan3 frotz geas git glulxe hugo jacl \
		level9 magnetic nitfol scare tadsr
	do
		doins ${terp} || die
		dosym "${GAMES_PREFIX}/libexec/${PN}/${terp}" \
			"${GAMES_BINDIR}/${PN}-${terp}" || die
	done
	# N.B. the launcher binary is installed in libexec too, because it
	#      expects to find the interpreters in the same directory:
	doins ${PN}|| die
	dosym "${GAMES_PREFIX}/libexec/${PN}/${PN}" \
		"${GAMES_BINDIR}/${PN}" || die

	prepgamesdirs
}
