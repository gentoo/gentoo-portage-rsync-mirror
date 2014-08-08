# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-skype/selinux-skype-9999.ebuild,v 1.3 2014/08/08 18:49:23 swift Exp $
EAPI="5"

IUSE="alsa"
MODS="skype"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for skype"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
