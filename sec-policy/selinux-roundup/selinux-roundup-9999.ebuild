# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-roundup/selinux-roundup-9999.ebuild,v 1.3 2014/11/01 16:13:35 swift Exp $
EAPI="5"

IUSE=""
MODS="roundup"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for roundup"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
