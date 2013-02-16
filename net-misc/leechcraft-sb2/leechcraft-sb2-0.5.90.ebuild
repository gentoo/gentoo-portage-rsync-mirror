# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-sb2/leechcraft-sb2-0.5.90.ebuild,v 1.3 2013/02/16 21:31:28 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Next-generation sidebar for LeechCraft with combined launcher and tab switcher, as well as tray area"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
