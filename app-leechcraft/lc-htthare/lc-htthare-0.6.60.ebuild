# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-htthare/lc-htthare-0.6.60.ebuild,v 1.2 2014/04/02 17:27:14 zlogene Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Simple HTTP server for Leechcraft"

SLOT="0"
KEYWORDS="amd64 ~x86"

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"
