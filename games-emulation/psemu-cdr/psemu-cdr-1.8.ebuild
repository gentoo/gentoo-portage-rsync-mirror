# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-cdr/psemu-cdr-1.8.ebuild,v 1.13 2012/05/04 04:38:40 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="PSEmu plugin to read from CD-ROM"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/cdr-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}

PATCHES=( "${FILESDIR}"/${PV}-makefile-cflags.patch
	"${FILESDIR}"/${P}-ldflags.patch )

src_compile() {
	emake -C src OPTFLAGS="${CFLAGS}" GUI="gtk+2" || die "emake failed"
}

src_install() {
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe src/libcdr-* || die "doexe failed (1)"
	exeinto "$(games_get_libdir)"/psemu/cfg
	doexe src/cfg-gtk*/cfgCdr || die "doexe failed(2)"
	insinto "$(games_get_libdir)"/psemu/cfg
	doins cdr.cfg || die "doins failed"
	dodoc ReadMe.txt
	prepgamesdirs
}
