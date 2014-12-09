# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/App-cpanminus/App-cpanminus-1.702.0.ebuild,v 1.1 2014/12/09 21:28:31 dilfridge Exp $

EAPI=5
MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=1.7020
inherit perl-module

DESCRIPTION='get, unpack, build and install modules from CPAN'
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-ExtUtils-Install-1.460.0
	>=virtual/perl-ExtUtils-MakeMaker-6.580.0
	>=virtual/perl-Module-Build-0.38.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST="do parallel"
