# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/wkhtmltopdf/wkhtmltopdf-0.11.0_rc1.ebuild,v 1.1 2011/11/03 04:28:34 radhermit Exp $

EAPI="4"

inherit qt4-r2 multilib

DESCRIPTION="Convert html to pdf (and various image formats) using webkit"
HOMEPAGE="http://code.google.com/p/wkhtmltopdf/"
SRC_URI="http://wkhtmltopdf.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-webkit:4
	x11-libs/qt-core:4
	x11-libs/qt-svg:4
	x11-libs/qt-xmlpatterns:4"
DEPEND="${RDEPEND}"

# Tests pull data from websites and require a
# special patched version of qt so many fail
RESTRICT="test"

src_prepare() {
	sed -i -e "s:\(INSTALLBASE/\)lib:\1$(get_libdir):" src/lib/lib.pro || die
}

src_configure() {
	eqmake4 INSTALLBASE="${D}"/usr
}

src_test() {
	./scripts/test.sh || die "tests failed"
}

src_install() {
	default
	use examples && dodoc -r examples
}
