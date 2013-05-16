# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Path-Class/Path-Class-0.310.0.ebuild,v 1.5 2013/05/16 15:49:14 ago Exp $

EAPI=5

MODULE_AUTHOR=KWILLIAMS
MODULE_VERSION=0.31
inherit perl-module

DESCRIPTION="Cross-platform path specification manipulation"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=virtual/perl-File-Spec-0.870.0
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
	)
"

SRC_TEST="do"
