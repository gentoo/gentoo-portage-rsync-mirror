# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-clockspeed/selinux-clockspeed-2.20141203-r1.ebuild,v 1.2 2014/12/21 14:07:13 swift Exp $
EAPI="5"

IUSE=""
MODS="clockspeed"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for clockspeed"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi
