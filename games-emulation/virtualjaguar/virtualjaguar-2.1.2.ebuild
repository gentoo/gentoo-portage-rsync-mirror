# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/virtualjaguar/virtualjaguar-2.1.2.ebuild,v 1.1 2014/10/15 03:50:52 mr_bones_ Exp $

EAPI=5
inherit eutils qt4-r2 games

DESCRIPTION="an Atari Jaguar emulator"
HOMEPAGE="http://www.icculus.org/virtualjaguar/"
SRC_URI="http://www.icculus.org/virtualjaguar/tarballs/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[joystick,opengl,sound,video]
	sys-libs/zlib
	virtual/opengl
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
	dev-libs/libcdio"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.4"

S=${WORKDIR}/${PN}

src_prepare() {
	eqmake4 virtualjaguar.pro -o makefile-qt
}

src_compile() {
	emake -j1 libs
	emake
}

src_install() {
	dogamesbin ${PN}
	dodoc README docs/{TODO,WHATSNEW}
	doman docs/virtualjaguar.1
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "The ${PN} ROM path is no-longer hardcoded, "
	elog "set it from within, the ${PN} GUI."
	elog
	elog "The ROM extension supported by ${PN} is .j64, "
	elog ".jag files will be interpreted as Jaguar Server executables."
}
