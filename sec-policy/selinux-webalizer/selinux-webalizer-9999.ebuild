# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-webalizer/selinux-webalizer-9999.ebuild,v 1.2 2013/09/20 09:26:57 swift Exp $
EAPI="4"

IUSE=""
MODS="webalizer"
BASEPOL="9999"

DEPEND="sec-policy/selinux-apache"
RDEPEND="${DEPEND}"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for webalizer"

KEYWORDS=""
