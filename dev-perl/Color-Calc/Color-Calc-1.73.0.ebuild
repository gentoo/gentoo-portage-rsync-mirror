# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Color-Calc/Color-Calc-1.73.0.ebuild,v 1.1 2013/03/18 11:04:34 pinkbyte Exp $

EAPI=5

MODULE_AUTHOR=CFAERBER
MODULE_VERSION=1.073
inherit perl-module

DESCRIPTION='Simple calculations with RGB colors'

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Graphics-ColorNames-2.100.0
	>=dev-perl/Graphics-ColorNames-WWW-0.10.0
	>=dev-perl/Graphics-ColorObject-0.5.0
	>=dev-perl/Params-Validate-0.75"

DEPEND="${RDEPEND}
	dev-perl/Test-NoWarnings
	>=virtual/perl-Module-Build-0.380.0
	virtual/perl-Test-Simple
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
