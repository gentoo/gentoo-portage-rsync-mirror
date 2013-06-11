# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-sb2/lc-sb2-0.5.97.ebuild,v 1.1 2013/06/11 17:41:20 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Next-generation sidebar for LeechCraft with combined launcher and tab switcher, as well as tray area"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtdeclarative:4
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
