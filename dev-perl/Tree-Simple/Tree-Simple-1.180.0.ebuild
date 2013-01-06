# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-Simple/Tree-Simple-1.180.0.ebuild,v 1.4 2012/03/25 17:17:49 armin76 Exp $

EAPI=4

MODULE_AUTHOR=STEVAN
MODULE_VERSION=1.18
inherit perl-module

DESCRIPTION="A simple tree object"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? (
		>=virtual/perl-Test-Simple-0.47
		>=dev-perl/Test-Exception-0.15
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
