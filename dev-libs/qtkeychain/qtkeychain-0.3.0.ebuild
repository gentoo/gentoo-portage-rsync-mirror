# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qtkeychain/qtkeychain-0.3.0.ebuild,v 1.1 2014/03/13 14:22:22 johu Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt API for storing passwords securely"
HOMEPAGE="https://github.com/frankosterfeld/qtkeychain"
SRC_URI="https://github.com/frankosterfeld/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5"

DEPEND="
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtdbus:5
	)
	!qt5? (
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
	)
"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog ReadMe.txt )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build !qt5 WITH_QT4)
	)

	cmake-utils_src_configure
}
