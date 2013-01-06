# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Types-DateTime-MoreCoercions/MooseX-Types-DateTime-MoreCoercions-0.110.0.ebuild,v 1.1 2012/12/26 09:30:45 tove Exp $

EAPI=4

MODULE_AUTHOR=ILMARI
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Extensions to MooseX::Types::DateTime"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/DateTime-0.430.200
	>=dev-perl/DateTimeX-Easy-0.85.0
	>=dev-perl/Moose-0.410.0
	>=dev-perl/MooseX-Types-0.140.0
	>=dev-perl/MooseX-Types-DateTime-0.70.0
	>=dev-perl/MooseX-Types-0.40.0
	>=dev-perl/Time-Duration-Parse-0.60.0
	>=dev-perl/namespace-clean-0.80.0
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.270.0
		>=dev-perl/Test-use-ok-0.20.0
	)"

SRC_TEST=do
