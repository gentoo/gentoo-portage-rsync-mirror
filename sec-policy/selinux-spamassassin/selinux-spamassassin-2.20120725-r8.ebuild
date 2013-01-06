# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-spamassassin/selinux-spamassassin-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:05:16 swift Exp $
EAPI="4"

IUSE=""
MODS="spamassassin"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for spamassassin"

KEYWORDS="amd64 x86"
