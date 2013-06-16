# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ntop/selinux-ntop-2.20130424-r1.ebuild,v 1.2 2013/06/16 16:22:48 swift Exp $
EAPI="4"

IUSE=""
MODS="ntop"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ntop"

KEYWORDS="amd64 x86"
