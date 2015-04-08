# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/qterminal/qterminal-0.6.0.ebuild,v 1.1 2015/02/03 09:05:04 yngwin Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt-based multitab terminal emulator"
HOMEPAGE="https://github.com/qterminal/qterminal"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		x11-libs/libqxt
		~x11-libs/qtermwidget-${PV}[qt4(+)]
	)
	qt5? (
		dev-qt/linguist-tools:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		~x11-libs/qtermwidget-${PV}[qt5(-)]
	)"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use qt5)
		$(cmake-utils_use_use qt4 SYSTEM_QXT)
	)
	cmake-utils_src_configure
}
