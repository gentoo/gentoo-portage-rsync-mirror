# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-tpi/lc-tpi-0.5.95.ebuild,v 1.1 2013/05/02 15:37:28 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Task progress indicator quark for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtdeclarative:4
	~virtual/leechcraft-quark-sideprovider-${PV}"
RDEPEND="${DEPEND}"
