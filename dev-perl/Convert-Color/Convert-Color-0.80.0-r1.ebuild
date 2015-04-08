# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-Color/Convert-Color-0.80.0-r1.ebuild,v 1.1 2014/08/26 18:41:31 axs Exp $

EAPI=5

MODULE_AUTHOR=PEVANS
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Color space conversions and named lookups"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Module-Pluggable
	dev-perl/List-UtilsBy
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST=do
