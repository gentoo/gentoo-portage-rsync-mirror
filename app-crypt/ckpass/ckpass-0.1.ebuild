# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ckpass/ckpass-0.1.ebuild,v 1.2 2011/12/13 18:05:01 joker Exp $

EAPI=4

DESCRIPTION="An ncurses based password database client that is compatible with KeePass 1.x format databases"
HOMEPAGE="http://ckpass.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libkpass"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS
}
