# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.90.ebuild,v 1.13 2012/08/24 06:59:11 mr_bones_ Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
SRC_URI="http://linux.tlk.fr/games/Powermanga/download/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2[audio,joystick,video]
	media-libs/libpng
	x11-libs/libXext
	x11-libs/libXxf86dga
	media-libs/sdl-mixer[mod]"

src_prepare() {
	sed -i -e "/null/d" graphics/Makefile.in || die
	sed -i -e "/zozo/d" texts/text_en.txt || die
	sed -i -e '/^CFLAGS=/s/-O3 -Wall/${CFLAGS}/' configure.ac || die
	local f
	for f in src/assembler.S src/assembler_opt.S ; do
		einfo "patching $f"
		cat <<-EOF >> ${f}
		#if defined(__linux__) && defined(__ELF__)
		.section .note.GNU-stack,"",%progbits
		#endif
		EOF
	done
	epatch \
		"${FILESDIR}"/${P}-underlink.patch \
		"${FILESDIR}"/${P}-segfault.patch
	eautoreconf
}

src_configure() {
	egamesconf --prefix=/usr || die
}

src_install() {
	dogamesbin powermanga || die
	doman powermanga.6
	dodoc AUTHORS CHANGES README

	insinto "${GAMES_DATADIR}/powermanga"
	doins -r data sounds graphics texts || die

	find "${D}${GAMES_DATADIR}/powermanga/" -name "Makefil*" -exec rm -f \{\} +

	insinto /var/games
	local f
	for f in powermanga.hi-easy powermanga.hi powermanga.hi-hard ; do
		touch "${D}/var/games/${f}" || die
		fperms 660 "/var/games/${f}" || die
	done

	make_desktop_entry powermanga Powermanga
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "NOTE: The highscore file format has changed."
	ewarn "Older highscores will not be retained."
}
