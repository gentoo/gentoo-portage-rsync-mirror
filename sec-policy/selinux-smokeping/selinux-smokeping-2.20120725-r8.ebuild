# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-smokeping/selinux-smokeping-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:04:46 swift Exp $
EAPI="4"

IUSE=""
MODS="smokeping"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for smokeping"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-apache
"
RDEPEND="${DEPEND}"
