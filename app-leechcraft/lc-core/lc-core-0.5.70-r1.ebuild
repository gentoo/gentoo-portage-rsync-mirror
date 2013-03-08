# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-core/lc-core-0.5.70-r1.ebuild,v 1.1 2013/03/08 21:56:19 maksbotan Exp $

EAPI="4"

EGIT_REPO_URI="git://github.com/0xd34df00d/leechcraft.git"
EGIT_PROJECT="leechcraft-${PV}"

inherit eutils confutils leechcraft

DESCRIPTION="Core of LeechCraft, the modular network client"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug +sqlite postgres"

DEPEND=">=dev-libs/boost-1.46
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtscript:4
		dev-qt/qtsql:4[postgres?,sqlite?]"
RDEPEND="${DEPEND}
		dev-qt/qtsvg:4"

pkg_setup() {
	confutils_require_any postgres sqlite
}

src_configure() {
	local mycmakeargs=(
		-DWITH_PLUGINS=False
		-DLEECHCRAFT_VERSION=${PV}
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	make_desktop_entry leechcraft "LeechCraft" leechcraft.png
}
