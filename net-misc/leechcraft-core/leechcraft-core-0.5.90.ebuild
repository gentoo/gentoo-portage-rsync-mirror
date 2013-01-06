# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-core/leechcraft-core-0.5.90.ebuild,v 1.1 2012/12/25 16:43:11 maksbotan Exp $

EAPI="4"

EGIT_REPO_URI="git://github.com/0xd34df00d/leechcraft.git"
EGIT_PROJECT="leechcraft-${PV}"

inherit eutils confutils leechcraft

DESCRIPTION="Core of LeechCraft, the modular network client"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +sqlite postgres"

DEPEND=">=dev-libs/boost-1.46
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-script:4
		x11-libs/qt-sql:4[postgres?,sqlite?]"
RDEPEND="${DEPEND}
	x11-libs/qt-svg:4
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
