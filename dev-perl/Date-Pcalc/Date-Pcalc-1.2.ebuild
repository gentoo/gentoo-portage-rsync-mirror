# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Pcalc/Date-Pcalc-1.2.ebuild,v 1.14 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
SRC_URI="mirror://cpan/authors/id/S/ST/STBEY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~stbey/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc ~ppc64 x86"
IUSE=""

DEPEND="dev-lang/perl"
