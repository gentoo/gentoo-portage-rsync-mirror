# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgoldrunner/kgoldrunner-4.14.3.ebuild,v 1.5 2015/02/17 11:06:35 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="KDE: KGoldrunner is a game of action and puzzle solving"
HOMEPAGE="
	http://www.kde.org/applications/games/kgoldrunner/
	http://games.kde.org/game.php?game=kgoldrunner
"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdegames)
	media-libs/libsndfile
	media-libs/openal
"
RDEPEND="${DEPEND}"
