# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Getopt/MooseX-Getopt-0.520.0.ebuild,v 1.3 2013/02/10 08:45:48 tove Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=0.52
inherit perl-module

DESCRIPTION="A Moose role for processing command line options"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-0.560.0
	dev-perl/MooseX-Role-Parameterized
	>=dev-perl/Getopt-Long-Descriptive-0.81.0
	>=virtual/perl-Getopt-Long-2.370.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
	test? (
		dev-perl/Config-Any
		dev-perl/Path-Tiny
		>=dev-perl/Test-CheckDeps-0.2.0
		dev-perl/Test-Deep
		dev-perl/Test-Fatal
		>=dev-perl/Test-NoWarnings-1.40.0
		>=dev-perl/Test-Requires-0.50.0
		>=virtual/perl-Test-Simple-0.620.0
		dev-perl/Test-Trap
		>=dev-perl/Test-Warn-0.210.0
	)
"

SRC_TEST=do
