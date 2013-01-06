# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-privoxy/selinux-privoxy-2.20120725-r7.ebuild,v 1.1 2012/11/18 15:17:56 swift Exp $
EAPI="4"

IUSE=""
MODS="privoxy"
BASEPOL="2.20120725-r7"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for privoxy"

KEYWORDS="~amd64 ~x86"
