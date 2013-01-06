# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM-Sync/MLDBM-Sync-0.300.0.ebuild,v 1.2 2011/09/03 21:04:35 tove Exp $

EAPI=4

MODULE_AUTHOR=CHAMAS
MODULE_VERSION=0.30
inherit perl-module

DESCRIPTION="Safe concurrent access to MLDBM databases"

SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-perl/MLDBM"
DEPEND="${RDEPEND}
		test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
