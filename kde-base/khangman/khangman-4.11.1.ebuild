# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khangman/khangman-4.11.1.ebuild,v 1.1 2013/09/03 19:04:23 creffett Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Classical hangman game for KDE"
HOMEPAGE="http://www.kde.org/applications/education/khangman
http://edu.kde.org/khangman"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND=${DEPEND}
