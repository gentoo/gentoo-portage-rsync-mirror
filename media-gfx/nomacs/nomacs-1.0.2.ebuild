# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nomacs/nomacs-1.0.2.ebuild,v 1.1 2013/06/12 14:39:56 kensington Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Qt4-based image viewer"
HOMEPAGE="http://www.nomacs.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="raw"

RDEPEND="
	>=media-gfx/exiv2-0.20[zlib]
	>=dev-qt/qtcore-4.7.0:4
	>=dev-qt/qtgui-4.7.0:4
	raw? (
		>=media-libs/libraw-0.14
		>=media-libs/opencv-2.4.0[qt4]
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable raw)
	)
	cmake-utils_src_configure
}
