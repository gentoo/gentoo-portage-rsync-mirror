# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSpp/ExtUtils-XSpp-0.160.200.ebuild,v 1.3 2011/12/11 22:06:15 maekke Exp $

EAPI=4

MODULE_AUTHOR=MBARBON
MODULE_VERSION=0.1602
inherit perl-module

DESCRIPTION="XS for C++"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Differences
		dev-perl/Test-Base )"
RDEPEND=">=virtual/perl-ExtUtils-ParseXS-2.22.02"

SRC_TEST=do
