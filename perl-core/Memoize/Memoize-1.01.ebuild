# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Memoize/Memoize-1.01.ebuild,v 1.4 2009/12/16 21:52:59 abcd Exp $

inherit perl-module

MY_P=Memoize-${PV}
DESCRIPTION="Generic Perl function result caching system"
HOMEPAGE="http://perl.plover.com/Memoize/"
SRC_URI="mirror://cpan/authors/id/M/MJ/MJD/${P}.tar.gz"

LICENSE="Artistic GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND="dev-lang/perl"
