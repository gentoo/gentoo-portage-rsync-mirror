# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-sensord/selinux-sensord-2.20130424-r1.ebuild,v 1.2 2013/07/24 19:43:36 swift Exp $
EAPI="4"

IUSE=""
MODS="sensord"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for sensord"

KEYWORDS="amd64 x86"
