# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/qterm/qterm-0.5.12-r1.ebuild,v 1.1 2015/04/05 16:08:13 kensington Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A BBS client for Linux"
HOMEPAGE="http://qterm.sourceforge.net"
SRC_URI="mirror://sourceforge/qterm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	>=dev-qt/qtcore-4.5:4
	>=dev-qt/qtdbus-4.5:4
	>=dev-qt/qtgui-4.5:4[qt3support]
	>=dev-qt/qtscript-4.5:4
	dev-libs/openssl:0
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	kde-base/kdelibs
	dev-qt/qthelp:4
	dev-qt/qtwebkit:4"

PATCHES=(
	"${FILESDIR}/${PN}-0.5.11-gentoo.patch"
	"${FILESDIR}/${P}-qt4.patch"
	"${FILESDIR}/${P}-glibc216.patch"
)

src_install() {
	cmake-utils_src_install
	mv "${D}"/usr/bin/qterm "${D}"/usr/bin/QTerm || die
	dodoc README TODO
}
