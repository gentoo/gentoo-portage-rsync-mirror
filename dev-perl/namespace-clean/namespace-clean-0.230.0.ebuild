# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.230.0.ebuild,v 1.2 2012/09/01 12:03:38 grobian Exp $

EAPI=4

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/B-Hooks-EndOfScope-0.100.0
	>=dev-perl/Package-Stash-0.220.0
	>=dev-perl/Sub-Name-0.40.0
	>=dev-perl/Sub-Identify-0.40.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		>=virtual/perl-Test-Simple-0.88
	)
"

SRC_TEST=do
