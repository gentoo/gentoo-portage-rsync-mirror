# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-dovecot/selinux-dovecot-2.20140311-r2.ebuild,v 1.2 2014/05/29 20:23:13 swift Exp $
EAPI="4"

IUSE=""
MODS="dovecot"
BASEPOL="2.20140311-r2"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for dovecot"

KEYWORDS="amd64 x86"
