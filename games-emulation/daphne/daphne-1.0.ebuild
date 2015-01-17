# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/daphne/daphne-1.0.ebuild,v 1.8 2015/01/17 14:04:36 tupone Exp $

EAPI=5
inherit eutils toolchain-funcs games

DESCRIPTION="Laserdisc Arcade Game Emulator"
HOMEPAGE="http://www.daphne-emu.com/"
SRC_URI="http://www.daphne-emu.com/download/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/libogg
	media-libs/libvorbis
	media-libs/libsdl[video]
	media-libs/sdl-mixer
	media-libs/glew"
RDEPEND="${DEPEND}"

S=${WORKDIR}/v_1_0/src

src_prepare() {
	# Fix no sound issue with >=media-libs/libvorbis-1.2.0
	epatch "${FILESDIR}/${P}"-vorbisfilefix.patch

	# amd64 does not like int pointers
	epatch "${FILESDIR}/${P}"-typefix.patch

	epatch "${FILESDIR}/${P}"-gcc43.patch \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-zlib.patch \
		"${FILESDIR}"/${P}-underlink.patch

	sed -i "/m_appdir =/s:\.:${GAMES_DATADIR}/${PN}:" \
		io/homedir.cpp \
		|| die "sed homedir.cpp failed"
	sed -i "s:pics/:${GAMES_DATADIR}/${PN}/&:" \
		video/video.cpp \
		|| die "sed video.cpp failed"
	sed -i "s:sound/:${GAMES_DATADIR}/${PN}/&:" \
		sound/sound.cpp \
		|| die "sed sound.cpp failed"
	sed -i "s:./lib:$(games_get_libdir)/${PN}/lib:" \
		io/dll.h \
		|| die "sed dll.h failed"

	sed \
		-e "s:-DNATIVE_CPU_X86::" \
		-e "s:-DUSE_MMX::" \
		-e '/export USE_MMX = 1/s:^:# :' \
		Makefile.vars.linux_x86 >Makefile.vars \
		|| die "sed failed"
}

src_configure() {
	cd vldp2
	egamesconf --disable-accel-detect
}

src_compile() {
	local archflags

	if use x86; then
		archflags="-DNATIVE_CPU_X86 -DMMX_RGB2YUV -DUSE_MMX"
		export USE_MMX=1
	else
		# -fPIC is needed on amd64 but fails on x86.
		archflags="-fPIC"
	fi

	emake \
		CXX=$(tc-getCXX) \
		DFLAGS="${CXXFLAGS} ${archflags}"
	cd vldp2
	emake \
		-f Makefile.linux \
		CC=$(tc-getCC) \
		DFLAGS="${CFLAGS} ${archflags}"
}

src_install() {
	cd ..
	newgamesbin daphne.bin daphne
	exeinto "$(games_get_libdir)"/${PN}
	doexe libvldp2.so
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r pics roms sound
	dodoc doc/*.{ini,txt}
	dohtml -r doc/*
	prepgamesdirs
}
