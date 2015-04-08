# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-modemmanager/selinux-modemmanager-2.20141203-r4.ebuild,v 1.1 2015/03/22 13:47:31 swift Exp $
EAPI="5"

IUSE=""
MODS="modemmanager"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for modemmanager"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
DEPEND="${DEPEND}
	sec-policy/selinux-dbus
"
RDEPEND="${RDEPEND}
	sec-policy/selinux-dbus
"
