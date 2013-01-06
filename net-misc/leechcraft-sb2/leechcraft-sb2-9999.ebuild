# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-sb2/leechcraft-sb2-9999.ebuild,v 1.2 2012/12/20 13:48:44 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Next-generation sidebar for LeechCraft with combined launcher and tab switcher, as well as tray area"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
