# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.09.ebuild,v 1.8 2009/05/23 17:04:56 armin76 Exp $

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
