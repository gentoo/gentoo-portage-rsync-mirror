# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Number-Format-1.52.ebuild,v 1.5 2007/03/05 12:19:38 ticho Exp $

inherit perl-module

DESCRIPTION="Package for formatting numbers for display"
SRC_URI="mirror://cpan/authors/id/W/WR/WRW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/W/WR/WRW/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
