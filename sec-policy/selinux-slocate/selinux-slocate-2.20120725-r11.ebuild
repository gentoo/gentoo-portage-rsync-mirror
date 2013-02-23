# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-slocate/selinux-slocate-2.20120725-r11.ebuild,v 1.2 2013/02/23 17:24:25 swift Exp $
EAPI="4"

IUSE=""
MODS="slocate"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for slocate"

KEYWORDS="amd64 x86"
