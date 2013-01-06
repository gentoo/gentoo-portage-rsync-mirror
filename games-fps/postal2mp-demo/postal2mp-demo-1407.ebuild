# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/postal2mp-demo/postal2mp-demo-1407.ebuild,v 1.13 2012/02/05 06:03:51 vapier Exp $

inherit eutils unpacker games

DESCRIPTION="You play the Postal Dude: POSTAL 2 is only as violent as you are"
HOMEPAGE="http://www.gopostal.com/home/"
SRC_URI="mirror://3dgamers/postal2/Missions/postal2mpdemo-lnx-${PV}.tar.bz2"

LICENSE="postal2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="x11-libs/libXext
	sys-libs/glibc
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )"
DEPEND=">=sys-apps/portage-2.1"

S=${WORKDIR}

dir="${GAMES_PREFIX_OPT}/${PN}"
Ddir="${D}/${dir}"

src_unpack() {
	unpack ${A}
	unpack_makeself postal2mpdemo-lnx-${PV}.run
	rm -f postal2mpdemo-lnx-${PV}.run
	unpack ./postal2mpdemo.tar  && rm -f postal2mpdemo.tar
	unpack ./linux-specific.tar && rm -f linux-specific.tar
}

src_install() {
	insinto "${dir}"
	doins -r * || die

	games_make_wrapper ${PN} ./postal2-bin "${dir}"/System

	newicon postal2mpdemo.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Postal 2: Share the Pain (Demo)" ${PN}

	fperms 750 "${dir}"/System/{postal2,ucc}-bin
	prepgamesdirs
}
