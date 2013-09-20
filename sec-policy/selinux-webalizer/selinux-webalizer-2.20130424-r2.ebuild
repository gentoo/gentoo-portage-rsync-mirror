# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-webalizer/selinux-webalizer-2.20130424-r2.ebuild,v 1.3 2013/09/20 09:26:57 swift Exp $
EAPI="4"

IUSE=""
MODS="webalizer"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for webalizer"

DEPEND="sec-policy/selinux-apache"
RDEPEND="${DEPEND}"

KEYWORDS="amd64 x86"
