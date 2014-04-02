# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-kinotify/lc-kinotify-0.6.60.ebuild,v 1.2 2014/04/02 17:39:17 zlogene Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Fancy visual notifications for LeechCraft"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
		>=dev-qt/qtwebkit-4.6:4"
RDEPEND="${DEPEND}"
