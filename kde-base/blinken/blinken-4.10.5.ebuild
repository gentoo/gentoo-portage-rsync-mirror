# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blinken/blinken-4.10.5.ebuild,v 1.6 2013/08/02 14:29:59 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="KDE version of the Simon Says game."
HOMEPAGE="http://www.kde.org/applications/education/blinken
http://edu.kde.org/blinken"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkdeedu)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep knotify)
"
