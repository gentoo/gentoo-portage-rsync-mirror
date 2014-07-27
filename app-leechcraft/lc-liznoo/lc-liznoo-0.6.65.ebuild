# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-liznoo/lc-liznoo-0.6.65.ebuild,v 1.3 2014/07/27 18:00:13 ssuominen Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="UPower-based power manager for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	x11-libs/qwt:6
	dev-qt/qtdbus:4
	virtual/leechcraft-trayarea"
RDEPEND="${DEPEND}
	|| ( >=sys-power/upower-0.9.23 sys-power/upower-pm-utils )"

pkg_postinst() {
	if has_version '>=sys-power/upower-0.99'; then
		ewarn "If you need hibernate and suspend support, you need to downgrade"
		ewarn "sys-power/upower to 0.9.23 or switch to sys-power/upower-pm-utils"
	fi
}
