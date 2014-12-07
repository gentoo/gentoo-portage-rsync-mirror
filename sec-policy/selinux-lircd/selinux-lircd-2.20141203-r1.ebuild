# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-lircd/selinux-lircd-2.20141203-r1.ebuild,v 1.1 2014/12/07 11:49:45 perfinion Exp $
EAPI="5"

IUSE=""
MODS="lircd"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for lircd"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
