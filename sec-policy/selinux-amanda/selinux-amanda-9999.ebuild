# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-amanda/selinux-amanda-9999.ebuild,v 1.2 2014/08/08 18:49:35 swift Exp $
EAPI="5"

IUSE=""
MODS="amanda"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for amanda"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-inetd
"
RDEPEND="${DEPEND}"
