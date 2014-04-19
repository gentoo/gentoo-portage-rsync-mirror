# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-sssd/selinux-sssd-2.20140311-r2.ebuild,v 1.1 2014/04/19 14:12:47 swift Exp $
EAPI="4"

IUSE=""
MODS="sssd"
BASEPOL="2.20140311-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for sssd"

KEYWORDS="~amd64 ~x86"
