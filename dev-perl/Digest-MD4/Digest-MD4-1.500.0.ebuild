# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.500.0.ebuild,v 1.2 2011/09/03 21:04:27 tove Exp $

EAPI=4

MODULE_AUTHOR=MIKEM
MODULE_VERSION=1.5
MODULE_SECTION=DigestMD4
inherit perl-module

DESCRIPTION="MD4 message digest algorithm"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
