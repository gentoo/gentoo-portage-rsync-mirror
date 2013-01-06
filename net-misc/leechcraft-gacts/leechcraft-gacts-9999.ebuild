# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-gacts/leechcraft-gacts-9999.ebuild,v 1.1 2012/02/10 17:15:36 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Allows other LeechCraft modules to register global shortcuts"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/libqxt"
RDEPEND="${DEPEND}"
