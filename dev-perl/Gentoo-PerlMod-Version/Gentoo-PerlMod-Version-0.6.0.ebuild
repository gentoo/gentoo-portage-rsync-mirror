# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gentoo-PerlMod-Version/Gentoo-PerlMod-Version-0.6.0.ebuild,v 1.2 2014/05/14 20:26:06 zlogene Exp $

EAPI=4

MODULE_AUTHOR=KENTNL
MODULE_VERSION=0.6.0
inherit perl-module

DESCRIPTION="Convert arbitrary Perl Modules' versions into normalised Gentoo versions"

SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~x86"
IUSE="test"

RDEPEND="
	dev-perl/List-MoreUtils
	dev-perl/Sub-Exporter
	>=virtual/perl-version-0.770.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.400.300
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.980.0
	)
"

SRC_TEST="do"
