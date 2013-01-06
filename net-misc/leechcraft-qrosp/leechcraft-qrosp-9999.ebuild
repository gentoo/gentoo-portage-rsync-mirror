# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-qrosp/leechcraft-qrosp-9999.ebuild,v 1.3 2012/09/28 13:11:23 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Qrosp, scrpting support for LeechCraft via Qross."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	dev-libs/qjson
	dev-libs/qrosscore"
RDEPEND="${DEPEND}"
