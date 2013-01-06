# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-MoreUtils/Hash-MoreUtils-0.20.0.ebuild,v 1.1 2012/06/16 21:05:51 tove Exp $

EAPI="4"

MODULE_AUTHOR="REHSACK"
MODULE_VERSION=0.02

inherit perl-module

DESCRIPTION="Provide the stuff missing in Hash::Util"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
