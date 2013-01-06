# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/micropolis/micropolis-1.0.ebuild,v 1.6 2010/03/09 12:23:23 abcd Exp $

inherit eutils games

DESCRIPTION="Micropolis - free version of the well known city building simulation"
HOMEPAGE="http://www.donhopkins.com/home/micropolis/"
SRC_URI="http://www.donhopkins.com/home/micropolis/${PN}-activity-source.tgz
	http://rmdir.de/~michael/${PN}_git.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXpm
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	sys-devel/bison"

S="${WORKDIR}/${PN}-activity/"

dir="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack "${PN}-activity-source.tgz"
	cd "${S}"

	epatch "${DISTDIR}"/${PN}_git.patch
	sed -i -e "s:-O3:${CFLAGS}:" \
		src/tclx/config.mk src/{sim,tcl,tk}/makefile || die
}

src_compile() {
	emake -C src || die
}

src_install() {
	exeinto "${dir}/res"
	doexe src/sim/sim || die
	insinto "${dir}"
	doins -r activity cities images manual res || die

	games_make_wrapper micropolis res/sim "${dir}"
	doicon Micropolis.png
	make_desktop_entry micropolis "Micropolis" Micropolis

	prepgamesdirs
}
