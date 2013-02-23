# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-gpg/selinux-gpg-2.20120725-r11.ebuild,v 1.2 2013/02/23 17:24:20 swift Exp $
EAPI="4"

IUSE=""
MODS="gpg"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for gpg"

KEYWORDS="amd64 x86"
