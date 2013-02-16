# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-summary/leechcraft-summary-0.5.90.ebuild,v 1.3 2013/02/16 21:31:51 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Summary plugin for Leechcraft"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
