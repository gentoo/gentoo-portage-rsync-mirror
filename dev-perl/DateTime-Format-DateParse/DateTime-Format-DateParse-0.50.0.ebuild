# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-DateParse/DateTime-Format-DateParse-0.50.0.ebuild,v 1.2 2011/09/03 21:04:44 tove Exp $

EAPI=4

MODULE_AUTHOR=JHOBLITT
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Parses Date::Parse compatible formats"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND=">=dev-perl/DateTime-0.29
	dev-perl/DateTime-TimeZone
	dev-perl/TimeDate"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
