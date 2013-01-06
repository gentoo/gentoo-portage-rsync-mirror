# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-lackman/leechcraft-lackman-9999.ebuild,v 1.3 2012/07/15 15:51:57 kensington Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Package Manager for extensions, scripts, themes etc."

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=x11-libs/qt-webkit-4.6:4"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"
