# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-sensord/selinux-sensord-2.20130424-r2.ebuild,v 1.1 2013/07/24 19:39:00 swift Exp $
EAPI="4"

IUSE=""
MODS="sensord"
BASEPOL="2.20130424-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for sensord"

KEYWORDS="~amd64 ~x86"
