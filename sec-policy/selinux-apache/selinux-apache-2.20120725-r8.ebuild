# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-apache/selinux-apache-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:05:06 swift Exp $
EAPI="4"

IUSE=""
MODS="apache"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for apache"

KEYWORDS="amd64 x86"
DEPEND="${DEPEND}
	sec-policy/selinux-kerberos
"
RDEPEND="${DEPEND}"

POLICY_PATCH="${FILESDIR}/fix-make-gpg-optional-r8.patch"
