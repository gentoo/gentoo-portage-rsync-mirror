# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-CChecker/ExtUtils-CChecker-0.90.0.ebuild,v 1.1 2015/02/17 13:05:37 chainsaw Exp $

EAPI=5
MODULE_AUTHOR=PEVANS
MODULE_VERSION=0.09

inherit perl-module

DESCRIPTION="Configure-time utilities for using C headers"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Fatal
	virtual/perl-Test-Simple )
"
RDEPEND="virtual/perl-ExtUtils-CBuilder"
SRC_TEST="do"
