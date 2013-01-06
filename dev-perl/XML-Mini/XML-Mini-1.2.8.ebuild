# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Mini/XML-Mini-1.2.8.ebuild,v 1.5 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="pure perl API to create and parse XML"
HOMEPAGE="http://search.cpan.org/~pdeegan/"
SRC_URI="mirror://cpan/authors/id/P/PD/PDEEGAN/XML-Mini-1.2.8.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 sparc ~x86"

DEPEND="dev-lang/perl"

SRC_TEST="do"
