# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/krosswordpuzzle/krosswordpuzzle-0.15.6.2.1259326.ebuild,v 1.1 2011/10/17 21:17:54 dilfridge Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Crossword playing game and editor for KDE 4"
HOMEPAGE="http://kde-apps.org/content/show.php/KrossWordPuzzle?content=111726"
SRC_URI="http://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep libkdegames)
"
DEPEND="${RDEPEND}"
