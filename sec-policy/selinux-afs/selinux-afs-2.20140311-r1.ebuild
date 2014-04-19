# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-afs/selinux-afs-2.20140311-r1.ebuild,v 1.2 2014/04/19 15:51:43 swift Exp $
EAPI="4"

IUSE=""
MODS="afs"
BASEPOL="2.20140311-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for afs"

KEYWORDS="amd64 x86"
