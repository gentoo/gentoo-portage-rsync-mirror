# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/leechcraft-xproxy/leechcraft-xproxy-9999.ebuild,v 1.1 2012/04/14 18:34:02 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides advanced proxy support features for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
