# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/mtavc/mtavc-0.5.ebuild,v 1.2 2008/05/15 13:10:51 nyhm Exp $

inherit eutils games

DESCRIPTION="dedicated server for GTA3 multiplayer"
HOMEPAGE="http://mtavc.com/"
SRC_URI="http://files.gonnaplay.com/201/MTAServer0_5-linux.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND="sys-libs/lib-compat"

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
