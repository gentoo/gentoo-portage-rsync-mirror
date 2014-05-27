# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/antimicro/antimicro-2.3.3.ebuild,v 1.1 2014/05/27 18:11:24 hasufell Exp $

EAPI=5
inherit eutils cmake-utils

DESCRIPTION="Map keyboard and mouse buttons to gamepad buttons"
HOMEPAGE="https://github.com/Ryochan7/antimicro"
SRC_URI="https://github.com/Ryochan7/antimicro/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-libs/libsdl2[joystick]
	x11-libs/libX11
	x11-libs/libXtst"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DUSE_SDL_2=ON
	)

	cmake-utils_src_configure
}
