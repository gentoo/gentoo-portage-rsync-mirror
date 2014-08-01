# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-pulseaudio/selinux-pulseaudio-2.20140311-r3.ebuild,v 1.2 2014/08/01 21:04:45 swift Exp $
EAPI="5"

IUSE=""
MODS="pulseaudio"
BASEPOL="2.20140311-r3"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for pulseaudio"

KEYWORDS="amd64 x86"
