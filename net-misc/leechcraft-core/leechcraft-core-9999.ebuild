# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-core/leechcraft-core-9999.ebuild,v 1.14 2013/03/02 23:02:12 hwoarang Exp $

EAPI="4"

EGIT_REPO_URI="git://github.com/0xd34df00d/leechcraft.git"
EGIT_PROJECT="leechcraft-${PV}"

inherit eutils confutils leechcraft

DESCRIPTION="Core of LeechCraft, the modular network client"

SLOT="0"
KEYWORDS=""
IUSE="debug +sqlite postgres"

DEPEND=">=dev-libs/boost-1.46
		dev-qt/qtcore:4
		dev-qt/qtdeclarative:4
		dev-qt/qtgui:4
		dev-qt/qtscript:4
		dev-qt/qtsql:4[postgres?,sqlite?]"
RDEPEND="${DEPEND}
	dev-qt/qtsvg:4
	|| (
		kde-base/oxygen-icons
		x11-themes/kfaenza
	 )"

REQUIRED_USE="|| ( postgres sqlite )"

src_configure() {
	local mycmakeargs=(
		-DWITH_PLUGINS=False
	)
	if [[ ${PV} != 9999 ]]; then
		mycmakeargs+=( -DLEECHCRAFT_VERSION=${PV} )
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	make_desktop_entry leechcraft "LeechCraft" leechcraft.png
}
