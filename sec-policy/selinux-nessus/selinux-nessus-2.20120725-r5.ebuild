# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nessus/selinux-nessus-2.20120725-r5.ebuild,v 1.2 2012/10/04 18:29:41 swift Exp $
EAPI="4"

IUSE=""
MODS="nessus"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for nessus"

KEYWORDS="amd64 x86"
