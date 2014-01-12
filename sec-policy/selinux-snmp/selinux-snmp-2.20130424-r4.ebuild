# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-snmp/selinux-snmp-2.20130424-r4.ebuild,v 1.2 2014/01/12 20:22:24 swift Exp $
EAPI="4"

IUSE=""
MODS="snmp"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for snmp"

KEYWORDS="amd64 x86"
