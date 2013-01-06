# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Getopt/MooseX-Getopt-0.470.0.ebuild,v 1.1 2012/08/31 09:33:10 tove Exp $

EAPI=4

MODULE_AUTHOR=ETHER
MODULE_VERSION=0.47
inherit perl-module

DESCRIPTION="A Moose role for processing command line options"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-0.56
	dev-perl/MooseX-Role-Parameterized
	>=dev-perl/Getopt-Long-Descriptive-0.081
	>=virtual/perl-Getopt-Long-2.37
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		dev-perl/Path-Class
		dev-perl/Test-Deep
		dev-perl/Test-Fatal
		>=dev-perl/Test-Requires-0.05
		>=virtual/perl-Test-Simple-0.62
		dev-perl/Test-Trap
		>=dev-perl/Test-Warn-0.21
	)
"

SRC_TEST=do
