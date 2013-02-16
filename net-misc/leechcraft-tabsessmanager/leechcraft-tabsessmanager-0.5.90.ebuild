# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-tabsessmanager/leechcraft-tabsessmanager-0.5.90.ebuild,v 1.3 2013/02/16 21:32:03 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Provides session restore between LeechCraft runs as well as manual saves/restores"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
