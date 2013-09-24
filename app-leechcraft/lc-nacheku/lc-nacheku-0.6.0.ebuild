# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-nacheku/lc-nacheku-0.6.0.ebuild,v 1.1 2013/09/24 15:48:44 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Monitors selected directory and clipboard for downloadable entities"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}"
RDEPEND="${DEPEND}"
