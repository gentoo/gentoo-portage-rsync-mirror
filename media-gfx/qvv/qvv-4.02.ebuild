# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qvv/qvv-4.02.ebuild,v 1.1 2010/10/06 21:31:42 chiiph Exp $

EAPI=2
inherit eutils qt4-r2

DESCRIPTION="QVV Image Viewer and Browser"
HOMEPAGE="http://cade.datamax.bg/qvv/"
SRC_URI="http://cade.datamax.bg/qvv/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_install() {
	dobin qvv || die "dobin failed"
	doicon images/qvv_icon_128x128.png || die "doicon failed"
	make_desktop_entry qvv QVV qvv_icon_128x128
	dodoc ANFSCD GPG_README HISTORY README todo.txt || die "dodoc failed"
}
