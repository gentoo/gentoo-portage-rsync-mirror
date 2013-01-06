# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-newlife/leechcraft-newlife-0.5.85.ebuild,v 1.1 2012/10/08 15:59:20 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="New Life imports settings from various other applications into LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
