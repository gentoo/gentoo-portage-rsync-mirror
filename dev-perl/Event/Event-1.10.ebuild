# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.10.ebuild,v 1.5 2012/10/09 01:22:30 blueness Exp $

inherit perl-module

DESCRIPTION="fast, generic event loop"
SRC_URI="mirror://cpan/authors/id/J/JP/JPRIT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86"
IUSE=""
SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"

DEPEND="dev-lang/perl"
