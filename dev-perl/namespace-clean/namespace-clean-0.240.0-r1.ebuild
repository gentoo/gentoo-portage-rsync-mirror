# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-clean/namespace-clean-0.240.0-r1.ebuild,v 1.2 2015/03/29 09:30:04 jer Exp $

EAPI=5

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="Keep imports and functions out of your namespace"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86 ~ppc-aix ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/B-Hooks-EndOfScope-0.120.0
	>=dev-perl/Package-Stash-0.220.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
	test? (
		>=virtual/perl-Test-Simple-0.880.0
	)
"

SRC_TEST=do
