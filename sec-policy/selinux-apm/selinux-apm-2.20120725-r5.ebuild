# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apm/selinux-apm-2.20120725-r5.ebuild,v 1.2 2012/10/04 18:29:31 swift Exp $
EAPI="4"

IUSE=""
MODS="apm"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for apm"

KEYWORDS="amd64 x86"
