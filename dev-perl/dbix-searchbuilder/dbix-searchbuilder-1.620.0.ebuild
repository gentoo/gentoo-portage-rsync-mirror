# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/dbix-searchbuilder/dbix-searchbuilder-1.620.0.ebuild,v 1.5 2012/08/27 18:39:12 armin76 Exp $

EAPI=4

MY_PN=DBIx-SearchBuilder
MODULE_AUTHOR=RUZ
MODULE_VERSION=1.62
inherit perl-module

DESCRIPTION="Encapsulate SQL queries and rows in simple perl objects"

SLOT="0"
KEYWORDS="amd64 hppa ~ppc x86"
IUSE="test"

RDEPEND="
	dev-perl/DBI
	dev-perl/DBIx-DBSchema
	dev-perl/Want
	>=dev-perl/Cache-Simple-TimedExpiry-0.210.0
	dev-perl/Clone
	dev-perl/Class-Accessor
	>=dev-perl/class-returnvalue-0.400.0
	>=dev-perl/capitalization-0.30.0
"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/DBD-SQLite
		>=virtual/perl-Test-Simple-0.520.0
	)
"

SRC_TEST="do"
