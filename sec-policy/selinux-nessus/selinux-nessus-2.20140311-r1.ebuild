# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-nessus/selinux-nessus-2.20140311-r1.ebuild,v 1.1 2014/03/21 19:13:37 swift Exp $
EAPI="4"

IUSE=""
MODS="nessus"
BASEPOL="2.20140311-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for nessus"

KEYWORDS="~amd64 ~x86"
