# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntop/selinux-ntop-2.20130424-r4.ebuild,v 1.2 2014/01/12 20:22:08 swift Exp $
EAPI="4"

IUSE=""
MODS="ntop"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ntop"

KEYWORDS="amd64 x86"
