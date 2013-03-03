# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/leechcraft-lhtr/leechcraft-lhtr-9999.ebuild,v 1.3 2013/03/02 23:55:22 hwoarang Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft HTML Text editoR component"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-qt/qtwebkit:4
	"
RDEPEND="${DEPEND}"
