# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yagf/yagf-0.8.7.ebuild,v 1.3 2012/09/03 13:39:11 kensington Exp $

EAPI="4"
inherit cmake-utils

DESCRIPTION="Graphical front-end for cuneiform OCR tool"
HOMEPAGE="http://symmetrica.net/cuneiform-linux/yagf-en.html"
SRC_URI="http://symmetrica.net/cuneiform-linux/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="scanner +cuneiform tesseract pdf"

REQUIRED_USE="|| ( cuneiform tesseract )"

DEPEND=">=x11-libs/qt-gui-4.7:4
	app-text/aspell"
RDEPEND="${DEPEND}
	cuneiform? ( app-text/cuneiform )
	tesseract? ( app-text/tesseract )
	scanner? ( media-gfx/xsane )
	pdf? ( || ( app-text/poppler[utils] app-text/ghostscript-gpl ) )"

DOCS="AUTHORS ChangeLog DESCRIPTION README"

CMAKE_IN_SOURCE_BUILD=1
