# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-xscreensaver/selinux-xscreensaver-2.20130424-r1.ebuild,v 1.2 2013/06/16 16:23:00 swift Exp $
EAPI="4"

IUSE=""
MODS="xscreensaver"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for xscreensaver"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
