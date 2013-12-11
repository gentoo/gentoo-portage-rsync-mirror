# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-portmap/selinux-portmap-2.20130424-r4.ebuild,v 1.1 2013/12/11 13:20:55 swift Exp $
EAPI="4"

IUSE=""
MODS="portmap"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for portmap"

KEYWORDS="~amd64 ~x86"
