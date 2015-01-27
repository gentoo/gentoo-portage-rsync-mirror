# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/sni-qt/sni-qt-0.2.6.ebuild,v 1.2 2015/01/27 16:48:42 kensington Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A Qt plugin which turns all QSystemTrayIcon into StatusNotifierItems"
HOMEPAGE="https://launchpad.net/sni-qt"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="
	dev-libs/libdbusmenu-qt[qt4(+)]
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
"
DEPEND="${RDEPEND}
	test? ( dev-qt/qttest:4 )
"

src_prepare() {
	if ! use test ; then
		comment_add_subdirectory tests/auto
	fi

	cmake-utils_src_prepare
}
