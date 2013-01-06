# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dbskk/selinux-dbskk-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:05:01 swift Exp $
EAPI="4"

IUSE=""
MODS="dbskk"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dbskk"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-inetd
"
RDEPEND="${DEPEND}"
