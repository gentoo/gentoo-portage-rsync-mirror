# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia2code/dia2code-0.8.4.ebuild,v 1.5 2012/10/28 15:23:11 armin76 Exp $

EAPI=4

inherit flag-o-matic autotools

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

src_prepare() {
	eautoreconf # Needed to prevent maintainer-mode to get activated
}

src_install() {
	default
	doman dia2code.1
}
