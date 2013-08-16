# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Aliases/MooseX-Aliases-0.110.0.ebuild,v 1.1 2013/08/16 07:39:51 patrick Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Easy aliasing of methods and attributes in Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-1.90.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.56
	test? (
		>=dev-perl/Test-Fatal-0.003
		>=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Requires
	)
"

SRC_TEST="do"
