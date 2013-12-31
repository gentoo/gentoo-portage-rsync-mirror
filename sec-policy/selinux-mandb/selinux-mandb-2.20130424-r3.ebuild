# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mandb/selinux-mandb-2.20130424-r3.ebuild,v 1.1 2013/12/29 14:37:45 swift Exp $
EAPI="4"

IUSE=""
MODS="mandb"
BASEPOL="2.20130424-r3"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mandb"

KEYWORDS="~amd64 ~x86"
