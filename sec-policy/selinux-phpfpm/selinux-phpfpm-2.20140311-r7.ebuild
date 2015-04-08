# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-phpfpm/selinux-phpfpm-2.20140311-r7.ebuild,v 1.2 2014/12/07 13:21:12 perfinion Exp $
EAPI="5"

IUSE=""
MODS="phpfpm"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for phpfpm"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
fi
DEPEND="${DEPEND}
	sec-policy/selinux-apache
"
RDEPEND="${DEPEND}"
