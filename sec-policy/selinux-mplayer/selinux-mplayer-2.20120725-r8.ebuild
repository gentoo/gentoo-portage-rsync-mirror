# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mplayer/selinux-mplayer-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:04:58 swift Exp $
EAPI="4"

IUSE=""
MODS="mplayer"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mplayer"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
POLICY_PATCH="${FILESDIR}/fix-alsa-is-optional-r8.patch"
