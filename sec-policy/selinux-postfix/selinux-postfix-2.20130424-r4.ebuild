# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-postfix/selinux-postfix-2.20130424-r4.ebuild,v 1.1 2013/12/11 13:20:48 swift Exp $
EAPI="4"

IUSE=""
MODS="postfix"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for postfix"

KEYWORDS="~amd64 ~x86"
