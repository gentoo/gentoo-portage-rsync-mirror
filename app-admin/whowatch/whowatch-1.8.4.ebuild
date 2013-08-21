# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.8.4.ebuild,v 1.3 2013/08/21 15:12:47 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE=""

RDEPEND="
	sys-libs/ncurses
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-tinfo.patch
	epatch "${FILESDIR}"/${P}-select.patch
	eautoreconf
}

src_install() {
	dobin src/${PN}
	doman ${PN}.1
	dodoc AUTHORS ChangeLog README TODO
}
