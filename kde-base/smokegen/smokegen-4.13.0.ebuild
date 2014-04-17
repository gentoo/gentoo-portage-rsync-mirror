# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokegen/smokegen-4.13.0.ebuild,v 1.2 2014/04/17 00:43:27 johu Exp $

EAPI=5

KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - generators"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
HOMEPAGE="http://techbase.kde.org/Development/Languages/Smoke"

DEPEND="
	dev-qt/qtcore:4[aqua=]
"
RDEPEND="${DEPEND}"
