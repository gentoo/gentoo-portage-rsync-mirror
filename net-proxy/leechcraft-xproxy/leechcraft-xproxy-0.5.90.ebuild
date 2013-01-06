# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/leechcraft-xproxy/leechcraft-xproxy-0.5.90.ebuild,v 1.1 2012/12/25 16:53:53 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides advanced proxy support features for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
