# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dropbox/selinux-dropbox-9999.ebuild,v 1.1 2014/06/07 19:39:40 swift Exp $
EAPI="4"

IUSE=""
MODS="dropbox"
BASEPOL="9999"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dropbox"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
"
RDEPEND="${DEPEND}"
