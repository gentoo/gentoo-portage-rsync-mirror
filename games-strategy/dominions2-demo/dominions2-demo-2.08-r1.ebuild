# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dominions2-demo/dominions2-demo-2.08-r1.ebuild,v 1.6 2014/10/13 16:18:40 mgorny Exp $

EAPI=4

inherit games

DESCRIPTION="Dominions 2: The Ascension Wars is an epic turn-based fantasy strategy game"
HOMEPAGE="http://www.illwinter.com/dom2/index.html"
SRC_URI="!ppc? ( http://www.shrapnelgames.com/downloads/dom2demo_linux_x86.tgz )
	ppc? ( http://www.shrapnelgames.com/downloads/dom2demo_linux_ppc.tgz )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="mirror bindist strip"

DEPEND="
	|| (
		ppc? (
			virtual/glu
			virtual/opengl
			x11-libs/libXext
			x11-libs/libX11
		)
		!ppc? (
			virtual/glu[abi_x86_32(-)]
			virtual/opengl[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
		)
		amd64? (
			app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
		)
	)"
RDEPEND="${DEPEND}"

S=${WORKDIR}/dominions2demo
dir="${GAMES_PREFIX_OPT}/${PN}"
QA_PREBUILT="${dir:1}/dom2demo"

src_install() {

	insinto "${dir}"
	exeinto "${dir}"
	doins -r *
	doexe dom2demo

	games_make_wrapper dominions2-demo ./dom2demo "${dir}" "${dir}"

	prepgamesdirs
}
