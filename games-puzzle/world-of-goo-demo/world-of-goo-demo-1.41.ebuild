# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/world-of-goo-demo/world-of-goo-demo-1.41.ebuild,v 1.3 2010/03/10 15:44:09 nyhm Exp $

inherit eutils games

DESCRIPTION="World of Goo is a puzzle game with a strong emphasis on physics"
HOMEPAGE="http://2dboy.com/"

if [[ ${PN} == *-demo ]] ; then
	MY_PN="WorldOfGooDemo"
	SRC_URI="${MY_PN}.${PV}.tar.gz"
else
	MY_PN="WorldOfGoo"
	SRC_URI="${MY_PN}Setup.${PV}.tar.gz"
fi

LICENSE="2dboy-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="fetch strip"

# the package includes SDL/ogg/vorbis already
RDEPEND="sys-libs/glibc
	virtual/opengl
	virtual/glu
	>=sys-devel/gcc-3.4"
DEPEND=""

S=${WORKDIR}/${MY_PN}

QA_EXECSTACK="opt/${MY_PN}/WorldOfGoo.bin32
	opt/${MY_PN}/WorldOfGoo.bin64"

pkg_nofetch() {
	elog "To download the demo, visit http://worldofgoo.com/dl2.php?lk=demo"
	elog "and download ${A} and place it in ${DISTDIR}"
}

src_install() {
	local d=${GAMES_PREFIX_OPT}/${MY_PN}

	insinto "${d}"
	doins -r */ ${MY_PN%Demo}* || die

	games_make_wrapper ${MY_PN} "${d}"/${MY_PN%Demo}
	dodoc readme.html linux-issues.txt
	newicon icons/scalable.svg ${MY_PN}.svg
	make_desktop_entry ${MY_PN} "World of Goo (Demo)" ${MY_PN}

	pushd "${D}${d}" >/dev/null
	chmod a+rx ${MY_PN%Demo}* libs*/lib* || die
	popd >/dev/null

	prepgamesdirs
}
