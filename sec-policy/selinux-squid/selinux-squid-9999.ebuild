# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-squid/selinux-squid-9999.ebuild,v 1.1 2012/10/13 16:30:29 swift Exp $
EAPI="4"

IUSE=""
MODS="squid"
BASEPOL="9999"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for squid"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-apache
"
RDEPEND="${DEPEND}"
