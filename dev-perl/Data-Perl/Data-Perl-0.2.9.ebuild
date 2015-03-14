# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Perl/Data-Perl-0.2.9.ebuild,v 1.1 2015/03/14 13:26:18 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=MATTP
MODULE_VERSION=0.002009
inherit perl-module

DESCRIPTION="Base classes wrapping fundamental Perl data types"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Class-Method-Modifiers
	dev-perl/List-MoreUtils
	virtual/perl-Scalar-List-Utils
	dev-perl/Module-Runtime
	dev-perl/Role-Tiny
	virtual/perl-parent
	dev-perl/strictures
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		dev-perl/Test-Deep
		dev-perl/Test-Fatal
		dev-perl/Test-Output
	)
"

SRC_TEST="do"
