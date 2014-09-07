# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/mtavc/mtavc-0.5.ebuild,v 1.4 2014/09/07 11:31:57 ulm Exp $

inherit eutils games

DESCRIPTION="dedicated server for GTA3 multiplayer"
HOMEPAGE="http://mtavc.com/"
SRC_URI="http://files.gonnaplay.com/201/MTAServer0_5-linux.tar.gz"

LICENSE="MTA-0.5"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

RDEPEND="virtual/libstdc++"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	sed -i 's:NoName:Gentoo:' mtaserver.conf
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	dogamesbin "${FILESDIR}"/mtavc
	dosed "s:GENTOO_DIR:${dir}:" "${GAMES_BINDIR}"/mtavc

	exeinto "${dir}"
	newexe MTAServer${PV} MTAServer
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	local files="banned.lst motd.txt mtaserver.conf"
	doins ${files}
	dodoc README CHANGELOG
	for f in ${files} ; do
		dosym "${GAMES_SYSCONFDIR}"/${PN}/${f} "${dir}"/${f}
	done

	prepgamesdirs
}
