# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-sidebar/leechcraft-sidebar-9999.ebuild,v 1.3 2012/08/12 08:30:32 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Sidebar for LeechCraft with the list of tabs, quicklaunch area and tray area"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
