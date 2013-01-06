# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Olson-Abbreviations/Olson-Abbreviations-0.20.0.ebuild,v 1.1 2011/08/29 11:11:21 tove Exp $

EAPI=4

MODULE_AUTHOR=ECARROLL
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="globally unique timezones abbreviation handling"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Moose
	dev-perl/MooseX-AttributeHelpers
	dev-perl/MooseX-ClassAttribute"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
