# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-mozilla/selinux-mozilla-9999.ebuild,v 1.3 2014/08/08 18:49:34 swift Exp $
EAPI="5"

IUSE="alsa"
MODS="mozilla"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for mozilla"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
