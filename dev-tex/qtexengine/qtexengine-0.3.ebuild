# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/qtexengine/qtexengine-0.3.ebuild,v 1.4 2013/03/02 20:18:33 hwoarang Exp $

EAPI=4
inherit eutils qt4-r2

MY_PN=QTeXEngine

DESCRIPTION="TeX support for Qt"
HOMEPAGE="http://soft.proindependent.com/qtexengine/"
SRC_URI="mirror://berlios/qtiplot/${MY_PN}-${PV}-opensource.zip"

KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}

PATCHES=(
	"${FILESDIR}/${P}-dynlib.patch"
)

src_compile() {
	emake sub-src-all
}

src_test() {
	emake sub-test-all
}

src_install() {
	dolib.so lib${MY_PN}.so*
	insinto /usr/include
	doins src/${MY_PN}.h
	dodoc CHANGES.txt
	dohtml -r ./doc/html/*
}
