# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qcustomplot/qcustomplot-1.3.0.ebuild,v 1.1 2015/02/21 13:18:03 jlec Exp $

EAPI=5

inherit qmake-utils

DESCRIPTION="Qt C++ widget for plotting and data visualization"
HOMEPAGE="http://www.qcustomplot.com/"
SRC_URI="
	http://www.qcustomplot.com/release/${PV}/QCustomPlot-sharedlib.tar.gz -> ${PN}-sharedlib-${PV}.tar.gz
	http://www.qcustomplot.com/release/${PV}/QCustomPlot-source.tar.gz -> ${PN}-source-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
	)
		"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}-source

src_prepare() {
	sed \
		-e 's:../../::g' \
		-e '/CONFIG/s:shared.*:shared:g' \
		"${WORKDIR}"/${PN}-sharedlib/sharedlib-compilation/sharedlib-compilation.pro > ${PN}.pro || die
}

src_configure() {
	use qt4 && eqmake4
	use qt5 && eqmake5
}

src_install() {
	dolib.so lib${PN}*
	doheader ${PN}.h
	dodoc changelog.txt
}
