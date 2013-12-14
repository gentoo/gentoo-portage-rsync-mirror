# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/QtBitcoinTrader/QtBitcoinTrader-9999.ebuild,v 1.4 2013/12/14 03:28:27 alexxy Exp $

EAPI=5

if [[ $PV = *9999* ]]; then
	eclass=git-2
	EGIT_REPO_URI="
		git://github.com/JulyIGHOR/QtBitcoinTrader.git
		https://github.com/JulyIGHOR/QtBitcoinTrader.git"
	EGIT_BRANCH="testing"
	SRC_URI=""
	KEYWORDS=""
else
	eclass=vcs-snapshot
	SRC_URI="https://github.com/JulyIGHOR/QtBitcoinTrader/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit base fdo-mime qt4-r2 ${eclass}

DESCRIPTION="Mt.Gox and BTC-e Bitcoin Trading Client"
HOMEPAGE="https://github.com/JulyIGHOR/QtBitcoinTrader"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtgui:4
	dev-qt/qtmultimedia:4"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 \
		src/${PN}_Desktop.pro \
		PREFIX="${EPREFIX}/usr" \
		DESKTOPDIR="${EPREFIX}/usr/share/applications" \
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}
