# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-hotsensors/lc-hotsensors-0.6.60.ebuild,v 1.2 2014/04/02 17:23:34 zlogene Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Temperature sensors monitor plugin for LeechCraft"

# We should define license for this plugin explicitly
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}[qwt]
	~virtual/leechcraft-quark-sideprovider-${PV}
	dev-qt/qtdeclarative:4
	sys-apps/lm_sensors
	"
RDEPEND="${DEPEND}"
