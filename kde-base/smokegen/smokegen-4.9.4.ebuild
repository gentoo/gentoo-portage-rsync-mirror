# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/smokegen/smokegen-4.9.4.ebuild,v 1.2 2012/12/25 10:49:58 maekke Exp $

EAPI=4

KDE_REQUIRED="never"
inherit kde4-base

DESCRIPTION="Scripting Meta Object Kompiler Engine - generators"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="aqua debug"

DEPEND="
	x11-libs/qt-core:4[aqua=]
"
RDEPEND="${DEPEND}"

add_blocker smoke
