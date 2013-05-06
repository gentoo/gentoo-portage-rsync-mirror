# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mrtg/selinux-mrtg-2.20130424-r1.ebuild,v 1.1 2013/05/06 14:46:39 swift Exp $
EAPI="4"

IUSE=""
MODS="mrtg"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mrtg"

KEYWORDS="~amd64 ~x86"
