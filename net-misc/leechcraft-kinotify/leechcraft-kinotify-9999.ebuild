# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-kinotify/leechcraft-kinotify-9999.ebuild,v 1.3 2012/07/15 15:56:00 kensington Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Fancy visual notifications for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=x11-libs/qt-webkit-4.6:4"
RDEPEND="${DEPEND}"
