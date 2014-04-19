# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-googletalk/selinux-googletalk-2.20140311-r2.ebuild,v 1.2 2014/04/19 17:22:26 swift Exp $
EAPI="4"

IUSE="alsa"
MODS="googletalk"
BASEPOL="2.20140311-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for googletalk"

KEYWORDS="~amd64 ~x86"
