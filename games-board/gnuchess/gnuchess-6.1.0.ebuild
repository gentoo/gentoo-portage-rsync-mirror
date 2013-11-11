# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnuchess/gnuchess-6.1.0.ebuild,v 1.1 2013/11/11 13:56:00 sping Exp $

EAPI=2
inherit flag-o-matic games

DESCRIPTION="Console based chess interface"
HOMEPAGE="http://www.gnu.org/software/chess/chess.html"
SRC_URI="mirror://gnu/chess/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="readline"

DEPEND="readline? ( sys-libs/readline )"

src_configure() {
	strip-flags # bug #199097
	egamesconf \
		--disable-dependency-tracking \
		$(use_with readline)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS TODO README || die
	prepgamesdirs
}
