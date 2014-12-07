# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-screen/selinux-screen-2.20141203-r1.ebuild,v 1.1 2014/12/07 11:49:52 perfinion Exp $
EAPI="5"

IUSE=""
MODS="screen"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for screen"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
