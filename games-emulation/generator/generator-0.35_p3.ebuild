# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/generator/generator-0.35_p3.ebuild,v 1.10 2014/05/15 16:36:27 ulm Exp $

EAPI=2
inherit autotools eutils toolchain-funcs games

MY_P=${PN}-${PV/_p/-cbiere-r}
DESCRIPTION="Sega Genesis / Mega Drive emulator"
HOMEPAGE="http://www.ghostwhitecrab.com/generator/"
SRC_URI="http://www.ghostwhitecrab.com/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+sdlaudio svga"

DEPEND="virtual/jpeg
	media-libs/libsdl[joystick,video]
	sdlaudio? ( media-libs/libsdl[sound] )
	svga? ( media-libs/svgalib )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	mkdir my-bins

	epatch \
		"${FILESDIR}"/${P}-configure.patch \
		"${FILESDIR}"/${P}-underlink.patch

	sed -i \
		-e 's/@GTK_CFLAGS@//g' \
		main/Makefile.am \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	:
}

# builds SDL by default since otherwise -svga builds nothing
src_compile() {
	local mygui myguis

	myguis="sdl"
	use svga && myguis="${myguis} svgalib"

	for mygui in ${myguis}; do
		[[ -f Makefile ]] && emake clean
		egamesconf \
			--with-cmz80 \
			--with-${mygui} \
			--without-tcltk \
			--with-gcc=$(gcc-major-version) \
			$(use_with sdlaudio sdl-audio) \
			--disable-dependency-tracking || die
		emake -j1 || die "building ${mygui}"
		mv main/generator-${mygui} my-bins/
	done
}

src_install() {
	dogamesbin my-bins/* || die "dogamesbin failed"
	dodoc AUTHORS ChangeLog NEWS README TODO docs/*
	prepgamesdirs
}
