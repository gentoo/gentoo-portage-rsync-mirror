# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dominions2-demo/dominions2-demo-2.08-r1.ebuild,v 1.2 2012/11/26 10:22:43 pinkbyte Exp $

EAPI=4

inherit games

DESCRIPTION="Dominions 2: The Ascension Wars is an epic turn-based fantasy strategy game"
HOMEPAGE="http://www.shrapnelgames.com/Illwinter/d2/"
SRC_URI="!ppc? ( http://www.shrapnelgames.com/downloads/dom2demo_linux_x86.tgz )
	ppc? ( http://www.shrapnelgames.com/downloads/dom2demo_linux_ppc.tgz )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="!amd64? (
		virtual/glu
		virtual/opengl
		x11-libs/libXext
		x11-libs/libX11
	)
	amd64? (
		app-emulation/emul-linux-x86-opengl
		app-emulation/emul-linux-x86-xlibs
	)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/dominions2demo

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"
	doins -r *
	doexe dom2demo

	games_make_wrapper dominions2-demo ./dom2demo "${dir}" "${dir}"

	prepgamesdirs
}
