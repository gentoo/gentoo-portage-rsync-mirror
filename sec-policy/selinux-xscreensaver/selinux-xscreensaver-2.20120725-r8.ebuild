# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-xscreensaver/selinux-xscreensaver-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:04:53 swift Exp $
EAPI="4"

IUSE=""
MODS="xscreensaver"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for xscreensaver"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
