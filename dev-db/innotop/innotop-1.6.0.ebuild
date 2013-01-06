# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/innotop/innotop-1.6.0.ebuild,v 1.2 2008/11/18 16:00:47 tove Exp $

inherit perl-app

DESCRIPTION="innotop - A text-mode MySQL and InnoDB monitor like mytop, but with many more features"
HOMEPAGE="http://sourceforge.net/projects/innotop/"
SRC_URI="mirror://sourceforge/innotop/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	dev-perl/TermReadKey
	virtual/perl-Term-ANSIColor
	virtual/perl-Time-HiRes"

src_install() {
	perl-module_src_install
}
