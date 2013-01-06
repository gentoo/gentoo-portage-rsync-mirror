# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-lemon/leechcraft-lemon-0.5.90.ebuild,v 1.1 2012/12/25 16:47:14 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Network monitor plugin for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	~virtual/leechcraft-quark-sideprovider-${PV}
	x11-libs/qt-bearer:4
	x11-libs/qt-declarative:4
	dev-libs/libnl:3
	x11-libs/qwt:6
	"
RDEPEND="${DEPEND}"
