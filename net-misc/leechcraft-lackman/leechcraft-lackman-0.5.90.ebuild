# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-lackman/leechcraft-lackman-0.5.90.ebuild,v 1.1 2012/12/25 16:46:30 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Package Manager for extensions, scripts, themes etc."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=x11-libs/qt-webkit-4.6:4"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"
