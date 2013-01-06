# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dbadm/selinux-dbadm-2.20120725-r9.ebuild,v 1.1 2012/12/21 20:46:55 swift Exp $
EAPI="4"

IUSE=""
MODS="dbadm"
BASEPOL="2.20120725-r9"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dbadm"

KEYWORDS="~amd64 ~x86"
