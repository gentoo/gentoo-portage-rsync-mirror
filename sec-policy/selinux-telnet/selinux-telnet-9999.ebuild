# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-telnet/selinux-telnet-9999.ebuild,v 1.1 2012/10/13 16:30:47 swift Exp $
EAPI="4"

IUSE=""
MODS="telnet"
BASEPOL="9999"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for telnet"

KEYWORDS=""
DEPEND="${DEPEND}
	sec-policy/selinux-remotelogin
"
RDEPEND="${DEPEND}"
