# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Path-Class/Path-Class-0.350.0.ebuild,v 1.6 2015/05/31 19:53:25 zlogene Exp $

EAPI=5

MODULE_AUTHOR=KWILLIAMS
MODULE_VERSION=0.35
inherit perl-module

DESCRIPTION="Cross-platform path specification manipulation"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-Exporter
	>=virtual/perl-File-Spec-3.260.0
	virtual/perl-File-Temp
	virtual/perl-IO
	virtual/perl-Perl-OSType
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.360.100
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
