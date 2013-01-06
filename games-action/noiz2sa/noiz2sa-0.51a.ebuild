# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/noiz2sa/noiz2sa-0.51a.ebuild,v 1.12 2012/06/13 06:44:24 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Abstract Shooting Game"
HOMEPAGE="http://www.asahi-net.or.jp/~cs8k-cyu/windows/noiz2sa_e.html http://sourceforge.net/projects/noiz2sa/"
SRC_URI="mirror://sourceforge/noiz2sa/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="media-libs/sdl-mixer[vorbis]
	>=dev-libs/libbulletml-0.0.3
	virtual/opengl"

S=${WORKDIR}/${PN}/src

PATCHES=( "${FILESDIR}"/${P}-gcc41.patch
	"${FILESDIR}"/${P}-underlink.patch
)

src_prepare(){
	base_src_prepare

	sed -i \
		-e "s:/.noiz2sa.prf:/noiz2sa.prf:" \
		-e "s:getenv(\"HOME\"):\"${GAMES_STATEDIR}\":" \
		attractmanager.c \
		|| die "sed failed"

	cp makefile.lin Makefile || die "Failed copying Makefile"
}

src_install(){
	local datadir="${GAMES_DATADIR}/${PN}"

	dogamesbin ${PN} || die "dogamesbin failed"
	dodir "${datadir}" "${GAMES_STATEDIR}"
	cp -r ../noiz2sa_share/* "${D}/${datadir}" || die "cp failed"
	dodoc ../readme*
	touch "${D}${GAMES_STATEDIR}/${PN}.prf"
	fperms 660 "${GAMES_STATEDIR}/${PN}.prf"
	prepgamesdirs
}
