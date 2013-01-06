# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-pintab/leechcraft-pintab-0.5.85.ebuild,v 1.1 2012/10/08 16:00:01 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides support for pinning tabs for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
