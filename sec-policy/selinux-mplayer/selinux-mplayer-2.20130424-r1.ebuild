# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mplayer/selinux-mplayer-2.20130424-r1.ebuild,v 1.2 2013/06/16 16:22:53 swift Exp $
EAPI="4"

IUSE=""
MODS="mplayer"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mplayer"

KEYWORDS="amd64 x86"
