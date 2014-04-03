# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-lackman/lc-lackman-0.6.60.ebuild,v 1.3 2014/04/03 08:24:12 zlogene Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Package Manager for extensions, scripts, themes etc."

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
		>=dev-qt/qtwebkit-4.6:4"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"
