# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/style-check/style-check-0.12.ebuild,v 1.2 2010/08/07 13:28:35 graaff Exp $

IUSE=""

DESCRIPTION="Parses latex-formatted text in search of forbidden phrases"
HOMEPAGE="http://www.cs.umd.edu/~nspring/software/style-check-readme.html"
SRC_URI="http://www.cs.umd.edu/~nspring/software/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND="=dev-lang/ruby-1.8*"

src_install() {
	dodir /etc/style-check.d
	emake PREFIX=/usr DESTDIR="${D}" install || die "make install failed"
	dodoc README
	dohtml README.html
}
