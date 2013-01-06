# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/leechcraft-dolozhee/leechcraft-dolozhee-9999.ebuild,v 1.1 2012/04/14 18:36:05 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="An issue reporting client for LeechCraft's issue tracker"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"
