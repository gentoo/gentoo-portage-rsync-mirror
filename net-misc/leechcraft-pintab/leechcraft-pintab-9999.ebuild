# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-pintab/leechcraft-pintab-9999.ebuild,v 1.2 2012/03/06 21:36:23 mr_bones_ Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides support for pinning tabs for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
