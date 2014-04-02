# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-woodpecker/lc-woodpecker-0.6.60.ebuild,v 1.2 2014/04/02 18:37:05 zlogene Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Twitter client for LeechCraft"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
		dev-libs/qjson
		dev-libs/kqoauth"
RDEPEND="${DEPEND}"