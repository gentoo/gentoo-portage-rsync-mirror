# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/leechcraft-tpi/leechcraft-tpi-9999.ebuild,v 1.1 2012/11/10 18:29:23 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Task progress indicator quark for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-declarative:4
	~virtual/leechcraft-quark-sideprovider-${PV}"
RDEPEND="${DEPEND}"
