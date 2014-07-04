# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-tcsd/selinux-tcsd-2.20140311-r2.ebuild,v 1.2 2014/07/04 15:03:19 swift Exp $
EAPI="4"

IUSE=""
MODS="tcsd"
BASEPOL="2.20140311-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for tcsd"

KEYWORDS="amd64 x86"
