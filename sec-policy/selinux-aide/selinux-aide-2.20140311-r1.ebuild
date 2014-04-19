# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-aide/selinux-aide-2.20140311-r1.ebuild,v 1.2 2014/04/19 15:51:17 swift Exp $
EAPI="4"

IUSE=""
MODS="aide"
BASEPOL="2.20140311-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for aide"

KEYWORDS="amd64 x86"
