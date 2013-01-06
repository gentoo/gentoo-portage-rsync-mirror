# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/lugaru-demo/lugaru-demo-1.0b.ebuild,v 1.3 2010/05/12 15:48:07 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="3D arcade with unique fighting system and anthropomorphic characters"
HOMEPAGE="http://www.wolfire.com/lugaru"
SRC_URI="http://cdn.wolfire.com/games/lugaru-linux-x86-${PV}.bin"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	x86? (
		x11-libs/libX11
		x11-libs/libXext
	)"

S=${WORKDIR}/data

src_unpack() {
	tail -c +193061 "${DISTDIR}"/${A} > ${A}.zip
	unpack ./${A}.zip
	rm -f ${A}.zip

	# Duplicate file and can't be handled by portage, bug #14983
	rm -f "${S}/Data/Textures/Quit.png "
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/lugaru

	insinto "${dir}"
	doins -r Data *.png *.txt || die "doins failed"

	exeinto "${dir}"
	doexe lugaru lib*so* xdg-open || die "doexe failed"
	games_make_wrapper lugaru ./lugaru "${dir}" "${dir}"

	doicon lugaru.png
	make_desktop_entry lugaru Lugaru lugaru

	prepgamesdirs
}
