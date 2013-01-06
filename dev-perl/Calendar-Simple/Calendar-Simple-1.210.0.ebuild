# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Calendar-Simple/Calendar-Simple-1.210.0.ebuild,v 1.6 2012/09/01 11:14:53 grobian Exp $

EAPI=4

MODULE_AUTHOR=DAVECROSS
MODULE_VERSION=1.21
inherit perl-module

DESCRIPTION="Perl extension to create simple calendars"

SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86 ~ppc-aix"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
