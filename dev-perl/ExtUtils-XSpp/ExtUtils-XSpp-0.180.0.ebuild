# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.180.0.ebuild,v 1.1 2015/05/18 21:01:42 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-Digest-MD5-2.0.0
	>=virtual/perl-ExtUtils-ParseXS-3.70.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.400.0
	test? (
		dev-perl/Test-Differences
		dev-perl/Test-Base
	)
"

SRC_TEST="do parallel"
