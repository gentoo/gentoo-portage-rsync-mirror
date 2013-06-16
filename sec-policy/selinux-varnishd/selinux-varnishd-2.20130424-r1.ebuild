# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-varnishd/selinux-varnishd-2.20130424-r1.ebuild,v 1.2 2013/06/16 16:22:45 swift Exp $
EAPI="4"

IUSE=""
MODS="varnishd"
BASEPOL="2.20130424-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for varnishd"

KEYWORDS="amd64 x86"
