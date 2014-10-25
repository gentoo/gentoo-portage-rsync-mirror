# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oxygen-fonts/oxygen-fonts-0.4.2.ebuild,v 1.1 2014/10/25 15:07:41 mrueg Exp $

EAPI=5

inherit cmake-utils font

DESCRIPTION="Desktop/GUI font family for integrated use with the KDE desktop"
HOMEPAGE="https://projects.kde.org/projects/kde/workspace/oxygen-fonts"
SRC_URI="mirror://kde/stable/plasma/5.0.2/${P}.tar.xz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/extra-cmake-modules
	media-gfx/fontforge
"

src_configure() {
	local mycmakeargs=(
		-DOXYGEN_FONT_INSTALL_DIR="${FONTDIR}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	font_src_install
}
