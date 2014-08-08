# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-evolution/selinux-evolution-9999.ebuild,v 1.2 2014/08/08 18:50:02 swift Exp $
EAPI="5"

IUSE=""
MODS="evolution"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for evolution"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
