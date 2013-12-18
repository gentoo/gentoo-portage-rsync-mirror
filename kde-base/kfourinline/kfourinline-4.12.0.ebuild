# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kfourinline/kfourinline-4.12.0.ebuild,v 1.1 2013/12/18 19:57:33 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE four-in-a-row game."
HOMEPAGE="
	http://www.kde.org/applications/games/kfourinline/
	http://games.kde.org/game.php?game=kfourinline
"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
