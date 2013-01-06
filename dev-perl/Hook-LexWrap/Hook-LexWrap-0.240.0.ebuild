# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hook-LexWrap/Hook-LexWrap-0.240.0.ebuild,v 1.4 2012/03/25 15:41:11 armin76 Exp $

EAPI=4

MODULE_AUTHOR=CHORNY
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="Lexically scoped subroutine wrappers"

SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
