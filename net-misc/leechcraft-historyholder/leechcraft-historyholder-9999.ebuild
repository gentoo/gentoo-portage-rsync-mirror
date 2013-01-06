# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-historyholder/leechcraft-historyholder-9999.ebuild,v 1.2 2011/12/16 18:42:47 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="HistoryHolder keeps track of stuff downloaded in LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}
		virtual/leechcraft-search-show"
