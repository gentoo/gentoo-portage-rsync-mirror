# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.97.ebuild,v 1.7 2010/02/18 20:32:37 darkside Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
HOMEPAGE="http://search.cpan.org/~rhandom/"
SRC_URI="mirror://cpan/authors/id/R/RH/RHANDOM/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

mydoc="README"

DEPEND="dev-perl/IO-Multiplex
	dev-lang/perl"
