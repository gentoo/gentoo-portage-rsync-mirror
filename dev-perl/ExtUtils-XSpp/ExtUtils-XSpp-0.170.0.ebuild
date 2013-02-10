# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.170.0.ebuild,v 1.1 2013/02/10 15:17:26 tove Exp $

EAPI=5

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=0.1700
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	>=virtual/perl-Module-Build-0.400.0
	test? (
		dev-perl/Test-Differences
		dev-perl/Test-Base
	)
"
RDEPEND="
	>=virtual/perl-ExtUtils-ParseXS-2.22.02
"

SRC_TEST=do
