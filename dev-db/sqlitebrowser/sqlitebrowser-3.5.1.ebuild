# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-3.5.1.ebuild,v 1.1 2015/02/21 14:03:56 jlec Exp $

EAPI=5

inherit qt4-r2 eutils cmake-utils

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	dev-db/sqlite:3
	dev-java/antlr:0[cxx]
	dev-libs/qcustomplot[qt4?,qt5?]
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		)
	qt5? (
		dev-qt/linguist:5
		dev-qt/linguist-tools:5
		dev-qt/qtnetwork:5
		dev-qt/qttest:5
		dev-qt/qtwidgets:5
		)"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-3.3.1-unbundle.patch )

src_prepare() {
	# https://github.com/qingfengxia/qhexedit still bundled
	find libs/{antlr-2.7.7,qcustomplot-source} -delete || die
	cmake-utils_src_prepare
}

src_configure() {
	# Wait for unmask
	local mycmakeargs=(
		$(cmake-utils_use_use qt5)
	)
	cmake-utils_src_configure
}

src_test() {
	ls -l sqlb-unittests
}

src_install() {
	cmake-utils_src_install
	doicon images/sqlitebrowser.svg
	domenu distri/sqlitebrowser.desktop
}
