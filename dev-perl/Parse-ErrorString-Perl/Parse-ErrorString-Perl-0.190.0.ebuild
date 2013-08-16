# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-ErrorString-Perl/Parse-ErrorString-Perl-0.190.0.ebuild,v 1.1 2013/08/16 08:11:20 patrick Exp $

EAPI=4

MODULE_AUTHOR=AZAWAWI
MODULE_VERSION=0.19
inherit perl-module

DESCRIPTION="Parse error messages from the perl interpreter"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-XSAccessor
	virtual/perl-PodParser
	>=dev-perl/Pod-POM-0.27"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? ( dev-perl/Test-Differences )"

SRC_TEST=do
