# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/virtualjaguar/virtualjaguar-1.0.7.ebuild,v 1.8 2014/05/15 16:40:58 ulm Exp $

EAPI=2
inherit eutils games

DESCRIPTION="an Atari Jaguar emulator"
HOMEPAGE="http://www.icculus.org/virtualjaguar/"
SRC_URI="http://www.icculus.org/virtualjaguar/tarballs/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl[sound,joystick,opengl,video]"

S=${WORKDIR}/${P}-src

src_prepare() {
	mkdir obj || die
	edos2unix src/sdlemu_config.cpp
	epatch \
		"${FILESDIR}"/${PV}-cdintf_linux.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-array.patch

	sed -e "s:GENTOODIR:${GAMES_BINDIR}:" \
		"${FILESDIR}/virtualjaguar" > "${T}/virtualjaguar" || die
}

src_compile() {
	export SYSTYPE=__GCCUNIX__ \
		GLLIB=-lGL \
		SDLLIBTYPE=--libs
	emake obj/m68kops.h || die
	emake LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin vj "${T}/virtualjaguar" || die "dogamebin failed"
	dodoc docs/{README,TODO,WHATSNEW}
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "Please run ${PN} to create the necessary directories"
	elog "in your home directory.  After that you may place ROM files"
	elog "in ~/.vj/ROMs and they will be detected when you run virtualjaguar."
	elog "You may then select which ROM to run from inside the emulator."
	elog
	elog "If you have previously run a version of ${PV} please note that"
	elog "the location of the ROMs has changed."
}
