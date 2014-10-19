# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CPAN-Meta-Check/CPAN-Meta-Check-0.9.0.ebuild,v 1.1 2014/10/19 21:25:30 zlogene Exp $

EAPI=5

MODULE_AUTHOR=LEONT
MODULE_VERSION=0.009
inherit perl-module

DESCRIPTION='Verify requirements in a CPAN::Meta object'

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-CPAN-Meta-2.120.920
	>=virtual/perl-CPAN-Meta-Requirements-2.120.920
	virtual/perl-Module-Metadata
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Differences
	)
"

SRC_TEST="do"
