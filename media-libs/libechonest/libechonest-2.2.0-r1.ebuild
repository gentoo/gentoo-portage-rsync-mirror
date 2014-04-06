# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libechonest/libechonest-2.2.0-r1.ebuild,v 1.1 2014/04/06 19:05:59 ssuominen Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="A library for communicating with The Echo Nest"
HOMEPAGE="http://projects.kde.org/projects/playground/libs/libechonest"
SRC_URI="http://files.lfranchi.com/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0/2.2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="test" # Networking required

RDEPEND=">=dev-libs/qjson-0.5
	dev-qt/qtcore:4"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-qt/qttest:4"

DOCS=( AUTHORS README TODO )

PATCHES=( "${FILESDIR}"/${P}-always_use_QJSON_LIBRARIES.patch )

src_configure() {
	local mycmakeargs=(
		-DECHONEST_BUILD_TESTS=OFF
	)
	cmake-utils_src_configure
}
