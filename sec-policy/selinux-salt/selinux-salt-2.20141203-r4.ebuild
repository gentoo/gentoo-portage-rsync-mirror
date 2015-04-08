# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-salt/selinux-salt-2.20141203-r4.ebuild,v 1.1 2015/03/22 13:47:30 swift Exp $
EAPI="5"

IUSE=""
MODS="salt"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for salt"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
