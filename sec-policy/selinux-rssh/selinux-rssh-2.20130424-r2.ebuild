# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-rssh/selinux-rssh-2.20130424-r2.ebuild,v 1.1 2013/07/20 21:30:44 swift Exp $
EAPI="4"

IUSE=""
MODS="rssh"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for rssh"

KEYWORDS="~amd64 ~x86"
