# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flat/File-Flat-1.00.ebuild,v 1.11 2012/08/27 18:18:31 armin76 Exp $

inherit perl-module

DESCRIPTION="Implements a flat filesystem"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~adamk/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 hppa ~mips ppc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/Class-Autouse-1
	>=dev-perl/Test-ClassAPI-1.02
	>=dev-perl/File-Copy-Recursive-0.28
	>=dev-perl/File-Remove-0.21
	>=virtual/perl-File-Spec-0.85
	>=virtual/perl-File-Temp-0.14
	>=dev-perl/File-Remove-0.21
	>=dev-perl/File-Slurp-9999.04
	>=dev-perl/prefork-0.02
	dev-lang/perl"
