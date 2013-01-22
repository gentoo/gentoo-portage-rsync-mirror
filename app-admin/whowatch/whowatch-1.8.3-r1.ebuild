# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/whowatch/whowatch-1.8.3-r1.ebuild,v 1.5 2013/01/22 17:33:21 ago Exp $

EAPI=4
inherit eutils toolchain-funcs

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

	epatch \
		"${FILESDIR}"/${P}-exit.patch \
		"${FILESDIR}"/${P}-verbose.patch
}

src_install() {
	dobin src/${PN}
	doman ${PN}.1
	dodoc AUTHORS ChangeLog README TODO
}
