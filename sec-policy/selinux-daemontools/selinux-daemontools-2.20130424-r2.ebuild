# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-daemontools/selinux-daemontools-2.20130424-r2.ebuild,v 1.1 2013/07/20 21:30:45 swift Exp $
EAPI="4"

IUSE=""
MODS="daemontools"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for daemontools"

KEYWORDS="~amd64 ~x86"
