# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/nyancat/nyancat-1.2.1.ebuild,v 1.1 2015/04/03 18:13:30 mr_bones_ Exp $

EAPI=5
inherit games

DESCRIPTION="Nyan Cat Telnet Server"
HOMEPAGE="http://github.com/klange/nyancat"
SRC_URI="https://github.com/klange/nyancat/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	emake LFLAGS="${LDFLAGS} ${CFLAGS}"
}

src_install() {
	dogamesbin src/${PN}
	dodoc README.md
	prepgamesdirs
}
