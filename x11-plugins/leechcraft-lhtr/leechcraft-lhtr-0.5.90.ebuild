# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/leechcraft-lhtr/leechcraft-lhtr-0.5.90.ebuild,v 1.4 2013/02/16 21:33:56 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft HTML Text editoR component"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	x11-libs/qt-webkit:4
	"
RDEPEND="${DEPEND}"
