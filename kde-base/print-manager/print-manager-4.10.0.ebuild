# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/print-manager/print-manager-4.10.0.ebuild,v 1.1 2013/02/07 04:57:13 alexxy Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Manage print jobs and printers in KDE"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=net-print/cups-1.6.0[dbus]
"
RDEPEND="${DEPEND}
	!kde-misc/print-manager
"

add_blocker printer-applet
add_blocker system-config-printer-kde

src_configure() {
	mycmakeargs=( -DCUPS_1_6=ON )
	kde4-base_src_configure
}
