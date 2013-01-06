# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru-demo/lugaru-demo-1.0c.ebuild,v 1.2 2012/12/16 10:30:11 tupone Exp $
EAPI=4

inherit eutils games

DESCRIPTION="3D arcade with unique fighting system and anthropomorphic characters"
HOMEPAGE="http://www.wolfire.com/lugaru"
SRC_URI="http://cdn.wolfire.com/games/lugaru/lugaru-linux-x86-${PV}.bin"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	x86? (
		x11-libs/libX11
		x11-libs/libXext
	)"

QA_PREBUILT="${GAMES_PREFIX_OPT:1}"/${PN}/lugaru

S=${WORKDIR}/data

src_unpack() {
	tail -c +194469 "${DISTDIR}"/${A} > ${A}.zip
	unpack ./${A}.zip
	rm -f ${A}.zip

	# Duplicate file and can't be handled by portage, bug #14983
	rm -f "${S}/Data/Textures/Quit.png "
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r Data

	dodoc *.txt

	exeinto "${dir}"
	doexe lugaru
	games_make_wrapper ${PN} ./lugaru "${dir}" "${dir}"

	newicon lugaru.png ${PN}.png
	make_desktop_entry ${PN} "Lugaru Demo" ${PN}

	prepgamesdirs
}
