# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qtkeychain/qtkeychain-0.1.0.ebuild,v 1.1 2013/05/29 23:20:33 johu Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt API for storing passwords securely"
HOMEPAGE="https://github.com/frankosterfeld/qtkeychain"
SRC_URI="https://github.com/frankosterfeld/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-qt5.patch" )

src_configure() {
	local mycmakeargs=( -DQT5_BUILD=OFF )

	cmake-utils_src_configure
}
