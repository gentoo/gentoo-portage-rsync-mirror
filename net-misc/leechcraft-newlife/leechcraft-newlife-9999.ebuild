# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-newlife/leechcraft-newlife-9999.ebuild,v 1.2 2011/12/16 18:44:40 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="New Life imports settings from various other applications into LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
