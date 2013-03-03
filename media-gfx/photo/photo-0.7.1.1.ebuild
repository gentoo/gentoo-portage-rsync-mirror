# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photo/photo-0.7.1.1.ebuild,v 1.2 2013/03/02 21:39:03 hwoarang Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="Simple but powerful Qt4-based image viewer"
HOMEPAGE="http://qt-apps.org/content/show.php/Photo?content=147453"
SRC_URI="http://qt-apps.org/CONTENT/content-files/147453-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="media-gfx/exiv2
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-install-desktop.patch
}

#TODO: translations
