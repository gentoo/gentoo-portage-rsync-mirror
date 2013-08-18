# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-woodpecker/lc-woodpecker-9999.ebuild,v 1.1 2013/08/18 18:39:12 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Twitter client for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
		dev-libs/qjson
		dev-libs/kqoauth"
RDEPEND="${DEPEND}"