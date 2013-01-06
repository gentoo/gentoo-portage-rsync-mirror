# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/fb2edit/fb2edit-0.0.7.ebuild,v 1.2 2012/11/27 13:40:08 pinkbyte Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="a WYSIWYG FictionBook (fb2) editor"
HOMEPAGE="http://fb2edit.lintest.ru/"
SRC_URI="http://lintest.ru/pub/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxml2
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}
	x11-themes/hicolor-icon-theme"

DOCS=( AUTHORS README )

src_prepare() {
	# drop -g from CFLAGS
	sed -i -e '/^add_definitions(-W/s/-g//' CMakeLists.txt || die 'sed failed'
}
