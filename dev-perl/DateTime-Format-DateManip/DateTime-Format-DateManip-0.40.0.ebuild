# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-DateManip/DateTime-Format-DateManip-0.40.0.ebuild,v 1.1 2011/08/31 12:39:17 tove Exp $

EAPI=4

MODULE_AUTHOR=BBENNETT
MODULE_VERSION=0.04
MODULE_SECTION=dt-fmt-datemanip
inherit perl-module

DESCRIPTION="convert Date::Manip dates and durations to DateTimes and vice versa"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateManip
	dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
