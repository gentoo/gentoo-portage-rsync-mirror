# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Util/Module-Util-1.80.0.ebuild,v 1.1 2012/05/31 18:29:36 tove Exp $

EAPI=4

MODULE_AUTHOR=MATTLAW
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION="Module name tools and transformations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
	>=virtual/perl-Module-Build-0.400.0
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
