# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Readonly/Readonly-2.0.0.ebuild,v 1.2 2015/02/22 14:19:48 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SANKO
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="Facility for creating read-only scalars, arrays, hashes"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE="test"

DEPEND="
	virtual/perl-CPAN-Meta
	>=virtual/perl-Module-Build-0.380.0
	test? ( virtual/perl-Test-Simple )
"

SRC_TEST="do"
