# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/List-UtilsBy/List-UtilsBy-0.90.0.ebuild,v 1.1 2012/02/16 15:09:04 tove Exp $

EAPI=4

MODULE_AUTHOR=PEVANS
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Higher-order list utility functions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	>=virtual/perl-Module-Build-0.380.0
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST=do
