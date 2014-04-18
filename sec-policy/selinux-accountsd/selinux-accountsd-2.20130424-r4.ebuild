# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-accountsd/selinux-accountsd-2.20130424-r4.ebuild,v 1.2 2014/04/18 19:48:06 swift Exp $
EAPI="4"

IUSE=""
MODS="accountsd"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for accountsd"

KEYWORDS="amd64 x86"
