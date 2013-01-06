# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tail/File-Tail-0.99.3.ebuild,v 1.14 2008/11/26 21:06:17 gmsoft Exp $

inherit perl-module

DESCRIPTION="Perl extension for reading from continously updated files"
SRC_URI="mirror://cpan/authors/id/M/MG/MGRABNAR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mgrabnar/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/perl-Time-HiRes
	dev-lang/perl"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
