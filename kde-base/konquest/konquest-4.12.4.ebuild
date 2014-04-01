# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konquest/konquest-4.12.4.ebuild,v 1.1 2014/04/01 18:09:59 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KDE_SELINUX_MODULE="games"
inherit kde4-base

DESCRIPTION="Galactic Strategy KDE Game"
HOMEPAGE="
	http://www.kde.org/applications/games/konquest/
	http://games.kde.org/game.php?game=konquest
"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkdegames)"
RDEPEND="${DEPEND}"
