# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.600.0.ebuild,v 1.5 2012/03/25 17:22:49 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=0.6
inherit perl-module

DESCRIPTION="Format validation and more for Net:: related strings"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc x86"
IUSE="test"

RDEPEND="dev-perl/Class-Default"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
