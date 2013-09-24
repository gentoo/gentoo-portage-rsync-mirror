# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-lhtr/lc-lhtr-0.6.0.ebuild,v 1.1 2013/09/24 15:47:19 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="LeechCraft HTML Text editoR component"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	dev-qt/qtwebkit:4
	"
RDEPEND="${DEPEND}"
