# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-anhero/leechcraft-anhero-9999.ebuild,v 1.2 2011/12/16 18:39:59 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="AnHero, KDE-based crash handler for LeechCraft."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	>=kde-base/kdelibs-4.2.0"
RDEPEND="${DEPEND}"
