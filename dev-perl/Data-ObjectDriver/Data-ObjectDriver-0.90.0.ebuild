# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ObjectDriver/Data-ObjectDriver-0.90.0.ebuild,v 1.5 2012/03/02 21:34:23 ranger Exp $

EAPI=3

MODULE_AUTHOR=SIXAPART
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Simple, transparent data interface, with caching"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="test"

RDEPEND="dev-perl/Class-Trigger
	dev-perl/Class-Data-Inheritable
	dev-perl/Class-Accessor
	dev-perl/DBI"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Exception
		dev-perl/DBD-SQLite )"

SRC_TEST=do
