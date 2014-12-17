# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photoqt/photoqt-1.1.0.1.ebuild,v 1.3 2014/12/17 18:11:14 kensington Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Simple but powerful Qt-based image viewer"
HOMEPAGE="http://photoqt.org/"
SRC_URI="http://photoqt.org/pkgs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graphicsmagick exiv2"

DEPEND="dev-qt/linguist-tools:5
	dev-qt/qtmultimedia:5
	dev-qt/qtimageformats:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	exiv2? ( media-gfx/exiv2:= )
	graphicsmagick? ( media-gfx/graphicsmagick )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use graphicsmagick GM)
		$(cmake-utils_use exiv2 EXIV2)
	)
	cmake-utils_src_configure
}
