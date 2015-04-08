# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-Simple/Tree-Simple-1.250.0.ebuild,v 1.1 2015/02/21 00:41:33 monsieurp Exp $

EAPI=5

MODULE_AUTHOR=RSAVAGE
MODULE_VERSION=1.25
MODULE_A_EXT=tgz
inherit perl-module

DESCRIPTION="A simple tree object"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28
	test? (
		>=dev-perl/Test-Memory-Cycle-1.40
		>=virtual/perl-Test-Simple-0.47
		>=dev-perl/Test-Exception-0.15
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
