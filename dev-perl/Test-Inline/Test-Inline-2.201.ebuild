# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inline/Test-Inline-2.201.ebuild,v 1.11 2012/08/27 18:17:11 armin76 Exp $

inherit perl-module

DESCRIPTION="Inline test suite support for Perl"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Inline"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Test-Simple
	dev-lang/perl
	virtual/perl-Memoize
	>=dev-perl/Test-ClassAPI-1.02
	virtual/perl-Test-Harness
	>=virtual/perl-File-Spec-0.80
	>=dev-perl/Algorithm-Dependency-1.02
	>=dev-perl/Class-Autouse-1.15
	>=dev-perl/Config-Tiny-2.00
	>=dev-perl/File-Find-Rule-0.26
	>=dev-perl/File-Flat-1.00
	>=dev-perl/File-Slurp-9999.04
	>=dev-perl/Params-Util-0.05
	>=dev-perl/Pod-Tests-0.18"
