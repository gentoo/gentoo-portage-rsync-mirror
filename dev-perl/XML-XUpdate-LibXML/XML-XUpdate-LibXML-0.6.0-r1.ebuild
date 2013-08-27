# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XUpdate-LibXML/XML-XUpdate-LibXML-0.6.0-r1.ebuild,v 1.1 2013/08/27 13:23:04 idella4 Exp $

EAPI=5

inherit perl-module

DESCRIPTION="Process XUpdate commands over an XML document."
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pajas/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/XML-LibXML-1.61
		dev-perl/XML-LibXML-Iterator"
