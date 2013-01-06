# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moose/Moose-1.240.ebuild,v 1.5 2012/04/10 17:39:20 tove Exp $

EAPI=3

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.24
inherit perl-module

DESCRIPTION="A postmodern object system for Perl 5"

SLOT="0"
KEYWORDS="ppc"
IUSE="test"

RDEPEND="dev-perl/Data-OptList
	>=virtual/perl-Scalar-List-Utils-1.19
	>=dev-perl/Class-MOP-1.11
	>=dev-perl/List-MoreUtils-0.12
	>=dev-perl/Package-DeprecationManager-0.10
	>=dev-perl/Params-Util-1.00
	>=dev-perl/Sub-Exporter-0.980
	dev-perl/Sub-Name
	dev-perl/Try-Tiny
	dev-perl/Devel-GlobalDestruction"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.88
		dev-perl/Test-Fatal
		dev-perl/Test-LongString
		>=dev-perl/Test-Output-0.09
		>=dev-perl/Test-Requires-0.05
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Deep
		dev-perl/Module-Refresh
		)"

SRC_TEST=do
