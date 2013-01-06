# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Strptime/DateTime-Format-Strptime-1.500.0.ebuild,v 1.4 2011/09/24 13:26:39 grobian Exp $

EAPI=3

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.5000
inherit perl-module

DESCRIPTION="Parse and Format DateTimes using Strptime"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x64-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/DateTime
	>=dev-perl/DateTime-Locale-0.45
	>=dev-perl/DateTime-TimeZone-0.79
	>=dev-perl/Params-Validate-0.91"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST=do
