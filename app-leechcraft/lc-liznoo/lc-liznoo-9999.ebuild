# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-liznoo/lc-liznoo-9999.ebuild,v 1.3 2014/05/31 20:41:19 ssuominen Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="UPower-based power manager for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	|| ( sys-power/upower sys-power/upower-pm-utils )
	x11-libs/qwt:6
	dev-qt/qtdbus:4
	virtual/leechcraft-trayarea"
RDEPEND="${DEPEND}"
