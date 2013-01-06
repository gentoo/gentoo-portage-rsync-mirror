# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract/SQL-Abstract-1.720.0.ebuild,v 1.1 2011/08/29 09:39:12 tove Exp $

EAPI=4

MODULE_AUTHOR=FREW
MODULE_VERSION=1.72
inherit perl-module

DESCRIPTION="Generate SQL from Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Class-Accessor-Grouped-0.100.20
	>=dev-perl/Getopt-Long-Descriptive-0.086
	dev-perl/Hash-Merge"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Deep-0.106
		dev-perl/Test-Exception
		dev-perl/Test-Pod
		>=virtual/perl-Test-Simple-0.92
		dev-perl/Test-Warn
		>=dev-perl/Clone-0.31
	)"
#		dev-perl/Test-Pod-Coverage

SRC_TEST="do"
