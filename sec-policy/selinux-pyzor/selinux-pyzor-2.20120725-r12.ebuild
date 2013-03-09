# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pyzor/selinux-pyzor-2.20120725-r12.ebuild,v 1.1 2013/03/09 12:36:51 swift Exp $
EAPI="4"

IUSE=""
MODS="pyzor"
BASEPOL="2.20120725-r12"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for pyzor"

KEYWORDS="~amd64 ~x86"
