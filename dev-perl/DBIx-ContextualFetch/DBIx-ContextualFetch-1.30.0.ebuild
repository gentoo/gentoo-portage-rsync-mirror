# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-ContextualFetch/DBIx-ContextualFetch-1.30.0.ebuild,v 1.3 2011/09/03 21:04:45 tove Exp $

EAPI=4

MODULE_AUTHOR=TMTM
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86 ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/DBI-1.37"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		dev-perl/DBD-SQLite
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
