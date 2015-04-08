# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Stringprep/Unicode-Stringprep-1.105.0.ebuild,v 1.1 2015/02/21 20:33:55 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=CFAERBER
MODULE_VERSION=1.105
inherit perl-module

DESCRIPTION="Preparation of Internationalized Strings (RFC 3454)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Unicode-Normalize-1
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.420.0
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-NoWarnings
	)
"
