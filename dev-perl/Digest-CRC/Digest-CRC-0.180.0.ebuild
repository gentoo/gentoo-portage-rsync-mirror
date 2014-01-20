# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-CRC/Digest-CRC-0.180.0.ebuild,v 1.16 2014/01/20 20:28:41 vapier Exp $

EAPI=4

MODULE_AUTHOR=OLIMAUL
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="Generic CRC function"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 ~sh sparc x86 ~amd64-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0"

SRC_TEST="do"
