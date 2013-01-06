# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Memory-Cycle/Test-Memory-Cycle-1.40.0.ebuild,v 1.3 2012/03/24 19:54:33 armin76 Exp $

EAPI=4

MODULE_AUTHOR=PETDANCE
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Check for memory leaks and circular memory references"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=">=dev-perl/Devel-Cycle-1.04
	>=virtual/perl-Test-Simple-0.62"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
