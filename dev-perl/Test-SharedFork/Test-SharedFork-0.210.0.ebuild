# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SharedFork/Test-SharedFork-0.210.0.ebuild,v 1.3 2014/02/11 11:17:23 jer Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="fork test"

SLOT="0"
KEYWORDS="~amd64 hppa ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.880.0
		virtual/perl-Test-Harness
	)
"

SRC_TEST=do
