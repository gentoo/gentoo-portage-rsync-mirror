# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.8.3.ebuild,v 1.6 2012/02/05 18:22:23 armin76 Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="interactive who-like program that displays information about users currently logged on in real time"
HOMEPAGE="http://wizard.ae.krakow.pl/~mike/"
SRC_URI="http://wizard.ae.krakow.pl/~mike/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	tc-export CC
}

src_install() {
	dobin src/${PN} || die "dobin failed"
	doman ${PN}.1
	dodoc AUTHORS ChangeLog README TODO
}
