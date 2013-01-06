# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/leechcraft-lhtr/leechcraft-lhtr-9999.ebuild,v 1.1 2012/12/22 15:28:04 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft HTML Text editoR component"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-webkit
	"
RDEPEND="${DEPEND}"
