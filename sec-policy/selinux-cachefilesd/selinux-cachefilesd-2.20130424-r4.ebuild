# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-cachefilesd/selinux-cachefilesd-2.20130424-r4.ebuild,v 1.2 2014/01/19 19:25:26 swift Exp $
EAPI="4"

IUSE=""
MODS="cachefilesd"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for cachefilesd"

KEYWORDS="amd64 x86"
