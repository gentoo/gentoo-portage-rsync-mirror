# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/namespace-autoclean/namespace-autoclean-0.130.0.ebuild,v 1.5 2012/03/09 10:22:16 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=BOBTFISH
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="Keep imports out of your namespace"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~x64-macos"
IUSE="test"

RDEPEND=">=dev-perl/namespace-clean-0.200
	|| ( >=dev-perl/Moose-1.990 >=dev-perl/Class-MOP-0.80 )
	>=dev-perl/B-Hooks-EndOfScope-0.07"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		>=dev-perl/Moose-0.56
		dev-perl/Sub-Name
	)"

SRC_TEST=do
