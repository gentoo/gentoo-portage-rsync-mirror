# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mozilla/selinux-mozilla-9999.ebuild,v 1.2 2014/03/30 09:18:35 swift Exp $
EAPI="4"

IUSE="alsa"
MODS="mozilla"
BASEPOL="9999"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mozilla"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
