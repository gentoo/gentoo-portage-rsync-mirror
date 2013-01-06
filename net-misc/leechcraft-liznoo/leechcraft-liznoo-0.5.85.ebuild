# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-liznoo/leechcraft-liznoo-0.5.85.ebuild,v 1.1 2012/10/08 15:58:38 pinkbyte Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="UPower-based power manager for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	sys-power/upower
	x11-libs/qwt:6
	x11-libs/qt-dbus:4
	virtual/leechcraft-trayarea"
RDEPEND="${DEPEND}"
