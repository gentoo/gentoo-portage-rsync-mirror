# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gentoo-PerlMod-Version/Gentoo-PerlMod-Version-0.4.0.ebuild,v 1.1 2012/03/01 17:31:21 tove Exp $

EAPI=4

MODULE_AUTHOR=KENTNL
MODULE_VERSION=0.4.0
inherit perl-module

DESCRIPTION="Convert arbitrary Perl Modules' versions into normalised Gentoo versions"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/List-MoreUtils
	dev-perl/Sub-Exporter
	>=virtual/perl-version-0.77
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.96
	)
"

SRC_TEST="do"
