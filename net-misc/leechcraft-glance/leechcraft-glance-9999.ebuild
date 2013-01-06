# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-glance/leechcraft-glance-9999.ebuild,v 1.2 2011/12/16 18:42:24 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Glance, quick thumbnailed overview of opened tabs in LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
