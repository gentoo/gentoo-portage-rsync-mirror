# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru/lugaru-1.0c.ebuild,v 1.4 2014/04/26 18:04:46 ulm Exp $

inherit eutils unpacker games

DESCRIPTION="3D arcade with unique fighting system and anthropomorphic characters"
HOMEPAGE="http://www.wolfire.com/lugaru"
SRC_URI="${PN}-full-linux-x86-${PV}.bin"

LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	x86? (
		x11-libs/libX11
		x11-libs/libXext
	)"

S=${WORKDIR}/data

src_unpack() {
	# self unpacking zip archive; unzip warns about the exe stuff
	unpack_zip ${A}

	# Duplicate file and can't be handled by portage, bug #14983
	rm -f "${S}/Data/Textures/Quit.png "
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/lugaru

	insinto "${dir}"
	doins -r Data || die "doins failed"

	dodoc *.txt

	exeinto "${dir}"
	doexe ${PN} || die "doexe failed"
	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"

	doicon ${PN}.png
	make_desktop_entry ${PN} Lugaru ${PN}

	prepgamesdirs
}
