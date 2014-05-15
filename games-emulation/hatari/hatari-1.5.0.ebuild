# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/hatari/hatari-1.5.0.ebuild,v 1.8 2014/05/15 16:37:13 ulm Exp $

EAPI=2
inherit eutils toolchain-funcs cmake-utils games

DESCRIPTION="Atari ST emulator"
HOMEPAGE="http://hatari.berlios.de/"
SRC_URI="mirror://berlios/hatari/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl[X,sound,video]
	sys-libs/readline
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	games-emulation/emutos"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	# build with newer zlib (bug #387829)
	sed -i -e '1i#define OF(x) x' src/includes/unzip.h || die
	rm -f doc/CMakeLists.txt
}

src_configure() {
	mycmakeargs=(
		"-DCMAKE_VERBOSE_MAKEFILE=TRUE"
		"-DCMAKE_BUILD_TYPE:STRING=Release"
		"-DDATADIR=${GAMES_DATADIR}/${PN}"
		"-DBIN2DATADIR=${GAMES_DATADIR}/${PN}"
		"-DBINDIR=${GAMES_BINDIR}"
		"-DICONDIR=/usr/share/pixmaps"
		"-DDESKTOPDIR=/usr/share/applications"
		"-DMANDIR=/usr/share/man/man1"
		"-DDOCDIR=/usr/share/doc/${PF}"
		)
	cmake-utils_src_configure
}

src_install() {
	DOCS="readme.txt doc/*.txt" cmake-utils_src_install
	dohtml -r doc/
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	elog "You need a TOS ROM to run hatari. EmuTOS, a free TOS implementation,"
	elog "has been installed in $(games_get_libdir) with a .img extension (there"
	elog "are several from which to choose)."
	elog
	elog "Another option is to go to http://www.atari.st/ and get a real TOS:"
	elog "  http://www.atari.st/"
	elog
	elog "The first time you run hatari, you should configure it to find the"
	elog "TOS you prefer to use.  Be sure to save your settings."
	echo
}
