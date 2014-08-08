# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-webalizer/selinux-webalizer-9999.ebuild,v 1.3 2014/08/08 18:49:50 swift Exp $
EAPI="5"

IUSE=""
MODS="webalizer"

DEPEND="sec-policy/selinux-apache"
RDEPEND="${DEPEND}"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for webalizer"

KEYWORDS=""
