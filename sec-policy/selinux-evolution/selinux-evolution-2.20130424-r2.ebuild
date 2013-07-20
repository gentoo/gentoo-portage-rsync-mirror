# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-evolution/selinux-evolution-2.20130424-r2.ebuild,v 1.1 2013/07/20 21:30:30 swift Exp $
EAPI="4"

IUSE=""
MODS="evolution"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for evolution"

KEYWORDS="~amd64 ~x86"
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
