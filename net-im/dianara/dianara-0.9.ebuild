# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/dianara/dianara-0.9.ebuild,v 1.1 2013/08/06 11:33:46 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils qt4-r2

DESCRIPTION="Qt-based client for the pump.io distributed social network"
HOMEPAGE="http://dianara.nongnu.org/"
SRC_URI="mirror://nongnu/dianara/dianara-v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-crypt/qca:2
	app-crypt/qca-ossl:2
	dev-qt/qtdbus:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-libs/qjson
	dev-libs/qoauth"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-v${PV}

src_unpack() {
	default
}

src_prepare() {
	default
}

src_configure() {
	eqmake4
}

src_compile() {
	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	doman manual/*
	dodoc README TODO CHANGELOG BUGS
	doicon -s 32 icon/32x32/${PN}.png
	doicon -s 64 icon/64x64/${PN}.png
	domenu ${PN}.desktop
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
