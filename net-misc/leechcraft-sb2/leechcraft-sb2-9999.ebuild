# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-sb2/leechcraft-sb2-9999.ebuild,v 1.3 2013/03/02 23:04:02 hwoarang Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Next-generation sidebar for LeechCraft with combined launcher and tab switcher, as well as tray area"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-qt/qtdeclarative:4
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
