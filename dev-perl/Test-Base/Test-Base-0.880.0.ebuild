# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Base/Test-Base-0.880.0.ebuild,v 1.1 2015/02/21 00:38:15 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=INGY
MODULE_VERSION=0.88
inherit perl-module

DESCRIPTION="A Data Driven Testing Framework"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~s390 ~sh ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="
	dev-perl/Filter
	>=dev-perl/Spiffy-0.400.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		>=dev-perl/Algorithm-Diff-1.150.0
		>=virtual/perl-ExtUtils-MakeMaker-6.520.0
		>=dev-perl/Text-Diff-0.350.0
	)
"

SRC_TEST="do"
