# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-xproxy/lc-xproxy-0.6.65.ebuild,v 1.1 2014/04/10 18:05:18 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides advanced proxy support features for LeechCraft"

SLOT="0"
KEYWORDS=" ~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"
