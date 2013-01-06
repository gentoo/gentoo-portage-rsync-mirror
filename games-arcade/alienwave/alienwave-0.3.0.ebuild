# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/alienwave/alienwave-0.3.0.ebuild,v 1.14 2010/09/15 18:10:27 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="An ncurses-based Xenon clone"
HOMEPAGE="http://www.alessandropira.org/alienwave/aw.html"
SRC_URI="http://www.alessandropira.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/ncurses"

S=${WORKDIR}/${PN}

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_install() {
	dogamesbin alienwave || die "dogamesbin failed"
	dodoc TO_DO README STORY
	prepgamesdirs
}
