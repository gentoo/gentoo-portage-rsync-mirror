# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ldap/selinux-ldap-2.20120725-r5.ebuild,v 1.2 2012/10/04 18:29:18 swift Exp $
EAPI="4"

IUSE=""
MODS="ldap"
BASEPOL="2.20120725-r5"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for ldap"

KEYWORDS="amd64 x86"
