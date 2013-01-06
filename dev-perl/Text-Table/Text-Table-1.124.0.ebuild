# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Table/Text-Table-1.124.0.ebuild,v 1.1 2011/09/05 16:36:41 tove Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.124
inherit perl-module

DESCRIPTION="Organize Data in Tables"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Text-Aligner-0.05"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.36
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
