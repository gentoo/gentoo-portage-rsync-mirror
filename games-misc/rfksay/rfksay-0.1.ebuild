# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/rfksay/rfksay-0.1.ebuild,v 1.10 2013/11/14 22:01:59 mr_bones_ Exp $

inherit games

DESCRIPTION="Like cowsay, but different because it involves robots and kittens"
HOMEPAGE="http://www.robotfindskitten.org/"
#SRC_URI="http://www.redhotlunix.com/${PN}.tar.gz"
SRC_URI="mirror://gentoo/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	dogamesbin kittensay rfksay robotsay || die
	prepgamesdirs
}
