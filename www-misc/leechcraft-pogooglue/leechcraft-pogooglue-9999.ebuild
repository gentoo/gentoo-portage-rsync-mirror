# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/leechcraft-pogooglue/leechcraft-pogooglue-9999.ebuild,v 1.1 2012/10/13 14:02:07 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides searching with Google to other LeechCraft plugins"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
