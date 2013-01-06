# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-modemmanager/selinux-modemmanager-2.20120725-r9.ebuild,v 1.1 2012/12/21 20:47:06 swift Exp $
EAPI="4"

IUSE=""
MODS="modemmanager"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for modemmanager"

KEYWORDS="~amd64 ~x86"
DEPEND="${DEPEND}
	sec-policy/selinux-dbus
	sec-policy/selinux-networkmanager
"
RDEPEND="${DEPEND}"
