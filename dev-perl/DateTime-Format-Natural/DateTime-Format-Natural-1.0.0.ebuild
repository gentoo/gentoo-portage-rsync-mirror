# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Natural/DateTime-Format-Natural-1.0.0.ebuild,v 1.1 2012/06/02 19:02:34 tove Exp $

EAPI=4

MODULE_AUTHOR=SCHUBIGER
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Create machine readable date/time with natural parsing logic"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/boolean
	dev-perl/Clone
	dev-perl/DateTime
	dev-perl/DateTime-TimeZone
	dev-perl/Date-Calc
	virtual/perl-Getopt-Long
	dev-perl/Params-Validate
	dev-perl/List-MoreUtils
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0
	test? (
		dev-perl/Module-Util
		dev-perl/Test-MockTime
	)
"

SRC_TEST=do
