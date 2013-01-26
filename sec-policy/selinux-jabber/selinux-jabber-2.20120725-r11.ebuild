# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-jabber/selinux-jabber-2.20120725-r11.ebuild,v 1.1 2013/01/26 18:21:04 swift Exp $
EAPI="4"

IUSE=""
MODS="jabber"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for jabber"

KEYWORDS="~amd64 ~x86"
