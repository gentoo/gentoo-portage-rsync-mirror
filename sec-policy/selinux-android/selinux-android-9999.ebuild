# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-android/selinux-android-9999.ebuild,v 1.2 2014/11/01 16:13:35 swift Exp $
EAPI="5"

IUSE=""
MODS="android"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for android"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
