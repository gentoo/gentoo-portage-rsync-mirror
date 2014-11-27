# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dropbox/selinux-dropbox-9999.ebuild,v 1.5 2014/11/27 09:58:53 swift Exp $
EAPI="5"

IUSE=""
MODS="dropbox"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dropbox"

if [[ $PV == 9999* ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
DEPEND="${DEPEND}
	sec-policy/selinux-xserver
	sec-policy/selinux-dbus
"
RDEPEND="${RDEPEND}
	sec-policy/selinux-xserver
	sec-policy/selinux-dbus
"
