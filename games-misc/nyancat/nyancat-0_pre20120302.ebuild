# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/nyancat/nyancat-0_pre20120302.ebuild,v 1.4 2012/04/30 17:51:29 jdhore Exp $

EAPI=2
inherit games

DESCRIPTION="Nyan Cat Telnet Server"
HOMEPAGE="http://miku.acm.uiuc.edu/ http://github.com/klange/nyancat"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_compile() {
	emake LFLAGS="${LDFLAGS} ${CFLAGS}" || die
}

src_install() {
	dogamesbin src/${PN} || die
	dodoc README.md
	prepgamesdirs
}
