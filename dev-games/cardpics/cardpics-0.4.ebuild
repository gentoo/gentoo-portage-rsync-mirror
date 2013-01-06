# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cardpics/cardpics-0.4.ebuild,v 1.10 2008/02/17 13:03:37 drac Exp $

inherit games

DESCRIPTION="set of free cards sets"
HOMEPAGE="http://www.nongnu.org/cardpics/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
