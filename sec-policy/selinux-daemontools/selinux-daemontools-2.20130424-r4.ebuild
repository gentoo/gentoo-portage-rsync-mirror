# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-daemontools/selinux-daemontools-2.20130424-r4.ebuild,v 1.1 2013/12/11 13:20:26 swift Exp $
EAPI="4"

IUSE=""
MODS="daemontools"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for daemontools"

KEYWORDS="~amd64 ~x86"
