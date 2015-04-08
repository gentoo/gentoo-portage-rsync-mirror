# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-LibBuilder/ExtUtils-LibBuilder-0.04.ebuild,v 1.2 2013/08/03 20:17:50 mrueg Exp $

EAPI=5

MODULE_AUTHOR="AMBS"
MODULE_SECTION="ExtUtils"

inherit perl-module

DESCRIPTION="A tool to build C libraries"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	test? ( >=dev-perl/Test-Pod-1.22
		>=dev-perl/Test-Pod-Coverage-1.08 )"
RDEPEND=""

SRC_TEST="do"
