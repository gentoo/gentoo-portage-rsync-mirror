# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Statistics-Descriptive/Statistics-Descriptive-3.60.300.ebuild,v 1.4 2012/08/16 16:46:27 nativemad Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=3.0603
inherit perl-module

DESCRIPTION="Module of basic descriptive statistical functions"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
mydoc="UserSurvey.txt"
