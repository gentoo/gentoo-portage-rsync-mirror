# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/triptych-demo/triptych-demo-0.ebuild,v 1.9 2008/03/13 18:18:59 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="fast-paced tetris-like puzzler"
HOMEPAGE="http://www.chroniclogic.com/triptych.htm"
SRC_URI="http://www.chroniclogic.com/demo/triptych.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
RESTRICT="strip"
IUSE=""

DEPEND="x11-libs/libXext
	media-libs/libsdl
	virtual/opengl"

S=${WORKDIR}/triptych

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir "${dir}" "${GAMES_BINDIR}"

	cp -pPR * "${D}"/${dir}/
	games_make_wrapper triptych ./triptych "${dir}"

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	# Fix perms on status files #74217
	local f
	for f in triptych.{clr,cnt,scr} ; do
		f="${ROOT}/${GAMES_PREFIX_OPT}/${PN}/${f}"
		if [[ ! -e ${f} ]] ; then
			touch "${f}"
			chmod 660 "${f}"
			chown ${GAMES_USER}:${GAMES_GROUP} "${f}"
		fi
	done
}
