# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kbreakout/kbreakout-4.14.3.ebuild,v 1.5 2015/02/17 11:06:40 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
DECLARATIVE_REQUIRED="always"
inherit kde4-base

DESCRIPTION="KDE: A Breakout-like game for KDE"
HOMEPAGE="
	http://www.kde.org/applications/games/kbreakout/
	http://games.kde.org/game.php?game=kbreakout
"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
