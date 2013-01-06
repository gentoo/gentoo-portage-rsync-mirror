# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlitebrowser/sqlitebrowser-2.0_beta1-r2.ebuild,v 1.2 2012/05/21 19:48:51 ssuominen Exp $

EAPI=4
inherit eutils qt4-r2

DESCRIPTION="SQLite Database Browser"
HOMEPAGE="http://sqlitebrowser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_200_b1_src.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-core-4.6:4[qt3support]
	>=x11-libs/qt-gui-4.6:4[qt3support]
	>=x11-libs/qt-qt3support-4.6:4"
RDEPEND="${DEPEND}"

S=${WORKDIR}/trunk/${PN}

PATCHES=( "${FILESDIR}"/${P}-qt-4.7.0.patch
	"${FILESDIR}"/${P}-gold.patch )

src_install() {
	dobin ${PN}/${PN}
	newicon ${PN}/images/128.png ${PN}.png
	make_desktop_entry ${PN} "SQLite Database Browser"
}
