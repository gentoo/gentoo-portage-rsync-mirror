# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class/DBIx-Class-0.82.30.ebuild,v 1.1 2012/11/04 16:09:23 tove Exp $

EAPI=4

MODULE_AUTHOR=FREW
MODULE_VERSION=0.08203
inherit perl-module

DESCRIPTION="Extensible and flexible object <-> relational mapper"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix"
IUSE="test admin admin_script deploy replicated"

RDEPEND_MOOSE_BASIC="
	>=dev-perl/Moose-0.98
	>=dev-perl/MooseX-Types-0.21
"
RDEPEND_ADMIN_BASIC="
	>=dev-perl/JSON-Any-1.22
	>=dev-perl/MooseX-Types-JSON-0.02
	>=dev-perl/MooseX-Types-Path-Class-0.05
	>=dev-perl/namespace-autoclean-0.09
"

#	>=dev-perl/Class-DBI-Plugin-DeepAbstractSearch-0.08
#	dev-perl/Class-Trigger
#	>=dev-perl/DBIx-ContextualFetch-1.03
#	>=dev-perl/Date-Simple-3.03
#	dev-perl/DateTime-Format-MySQL
#	dev-perl/DateTime-Format-Pg
#	dev-perl/DateTime-Format-SQLite
#	dev-perl/DateTime-Format-Strptime
#	dev-perl/Devel-Cycle
#	dev-perl/Time-Piece-MySQL

RDEPEND="
	admin? (
		${RDEPEND_MOOSE_BASIC}
		${RDEPEND_ADMIN_BASIC}
	)
	admin_script? (
		${RDEPEND_MOOSE_BASIC}
		${RDEPEND_ADMIN_BASIC}
		>=dev-perl/Getopt-Long-Descriptive-0.081
		>=dev-perl/Text-CSV-1.16
	)
	deploy? (
		>=dev-perl/SQL-Translator-0.110.60
	)
	replicated? (
		${RDEPEND_MOOSE_BASIC}
		>=dev-perl/Hash-Merge-0.12
	)
	>=dev-perl/DBD-SQLite-1.29
	>=dev-perl/Carp-Clan-6.00
	>=dev-perl/Class-Accessor-Grouped-0.100.20
	>=dev-perl/Class-C3-Componentised-1.0.900
	>=dev-perl/Class-Inspector-1.24
	>=dev-perl/Config-Any-0.20
	dev-perl/Data-Compare
	>=dev-perl/Data-Page-2.01
	>=dev-perl/DBI-1.609
	dev-perl/Devel-GlobalDestruction
	>=virtual/perl-File-Path-2.08
	dev-perl/Hash-Merge
	>=dev-perl/Math-Base36-0.07
	>=virtual/perl-Math-BigInt-1.80
	>=dev-perl/MRO-Compat-0.11
	>=dev-perl/Module-Find-0.06
	>=dev-perl/Moo-0.9.100
	>=dev-perl/Path-Class-0.18
	>=dev-perl/SQL-Abstract-1.730
	>=dev-perl/Sub-Name-0.04
	>=dev-perl/Data-Dumper-Concise-2.20
	>=dev-perl/Scope-Guard-0.03
	dev-perl/Context-Preserve
	>=dev-perl/Try-Tiny-0.04
	>=dev-perl/namespace-clean-0.20
"
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-File-Temp-0.22
		>=dev-perl/Package-Stash-0.280.0
		>=dev-perl/Test-Exception-0.31
		>=dev-perl/Test-Warn-0.21
		>=virtual/perl-Test-Simple-0.94
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
