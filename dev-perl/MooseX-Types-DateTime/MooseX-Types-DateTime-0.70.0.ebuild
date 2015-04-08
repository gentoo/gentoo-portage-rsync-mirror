# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types-DateTime/MooseX-Types-DateTime-0.70.0.ebuild,v 1.2 2014/10/11 20:53:02 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ILMARI
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="DateTime related constraints and coercions for Moose"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/DateTime-0.430.200
	>=dev-perl/DateTime-Locale-0.400.100
	>=dev-perl/DateTime-TimeZone-0.950.0
	>=dev-perl/Moose-0.410.0
	>=dev-perl/MooseX-Types-0.300.0
	>=dev-perl/namespace-clean-0.80.0
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.270.0
		>=dev-perl/Test-use-ok-0.20.0
	)"

SRC_TEST=do
