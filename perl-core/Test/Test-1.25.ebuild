# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test/Test-1.25.ebuild,v 1.11 2014/01/20 20:46:18 vapier Exp $

MODULE_AUTHOR=SBURKE
inherit perl-module

DESCRIPTION="Utilities for writing test scripts"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
