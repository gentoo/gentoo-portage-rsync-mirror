# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-qemu/selinux-qemu-2.20120725-r5.ebuild,v 1.2 2012/10/04 18:29:29 swift Exp $
EAPI="4"

IUSE=""
MODS="qemu"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for qemu"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-virt
"
RDEPEND="${DEPEND}"
