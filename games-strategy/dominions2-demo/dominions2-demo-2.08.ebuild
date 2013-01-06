# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dominions2-demo/dominions2-demo-2.08.ebuild,v 1.3 2009/10/26 18:24:15 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="Dominions 2: The Ascension Wars is an epic turn-based fantasy strategy game"
HOMEPAGE="http://www.shrapnelgames.com/Illwinter/d2/"
SRC_URI="http://www.shrapnelgames.com/downloads/dom2demo_linux_x86.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

DEPEND="x11-libs/libXext
	virtual/opengl
	virtual/glu"

S=${WORKDIR}/dominions2demo

src_prepare() {
	chmod a+x ./dom2demo
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	dodir "${dir}"
	cp -r "${S}/"* "${D}${dir}" || die "cp failed"
	games_make_wrapper dominions2-demo ./dom2demo "${dir}" "${dir}"
	prepgamesdirs
}
