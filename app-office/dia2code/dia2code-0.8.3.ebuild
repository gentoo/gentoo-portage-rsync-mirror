# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia2code/dia2code-0.8.3.ebuild,v 1.7 2011/03/22 19:56:11 ranger Exp $

inherit flag-o-matic

DESCRIPTION="Convert UML diagrams produced with Dia to various source code flavours."
HOMEPAGE="http://dia2code.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}
	>=app-office/dia-0.90.0"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	doman dia2code.1 || die "doman failed"
}
