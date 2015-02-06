# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/nyancat/nyancat-0_pre20120302.ebuild,v 1.6 2015/02/06 21:40:27 tupone Exp $

EAPI=5
inherit games

DESCRIPTION="Nyan Cat Telnet Server"
HOMEPAGE="http://github.com/klange/nyancat"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_compile() {
	emake LFLAGS="${LDFLAGS} ${CFLAGS}"
}

src_install() {
	dogamesbin src/${PN}
	dodoc README.md
	prepgamesdirs
}
