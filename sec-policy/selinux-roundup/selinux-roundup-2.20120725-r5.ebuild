# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-roundup/selinux-roundup-2.20120725-r5.ebuild,v 1.2 2012/10/04 18:29:51 swift Exp $
EAPI="4"

IUSE=""
MODS="roundup"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for roundup"

KEYWORDS="amd64 x86"
