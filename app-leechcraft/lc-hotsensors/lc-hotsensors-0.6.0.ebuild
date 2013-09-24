# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-hotsensors/lc-hotsensors-0.6.0.ebuild,v 1.1 2013/09/24 15:44:38 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Temperature sensors monitor plugin for LeechCraft"

# We should define license for this plugin explicitly
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	~virtual/leechcraft-quark-sideprovider-${PV}
	dev-qt/qtdeclarative:4
	x11-libs/qwt:6
	sys-apps/lm_sensors
	"
RDEPEND="${DEPEND}"
