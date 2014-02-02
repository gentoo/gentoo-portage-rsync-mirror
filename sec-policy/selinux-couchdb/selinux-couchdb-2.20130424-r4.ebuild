# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-couchdb/selinux-couchdb-2.20130424-r4.ebuild,v 1.2 2014/02/02 10:26:20 swift Exp $
EAPI="4"

IUSE=""
MODS="couchdb"
BASEPOL="2.20130424-r4"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for couchdb"

KEYWORDS="amd64 x86"
