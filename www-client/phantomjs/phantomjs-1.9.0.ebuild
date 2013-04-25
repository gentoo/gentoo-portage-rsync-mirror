# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/phantomjs/phantomjs-1.9.0.ebuild,v 1.2 2013/04/25 21:11:29 zx2c4 Exp $

EAPI=5

DESCRIPTION="A headless WebKit scriptable with a JavaScript API."
HOMEPAGE="http://phantomjs.org/"
SRC_URI="https://phantomjs.googlecode.com/files/${P}-source.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="media-libs/fontconfig media-libs/freetype dev-libs/icu"
RDEPEND="${DEPEND}"


src_prepare() {
	sed -i 's/# CONFIG += text_breaking_with_icu/CONFIG += text_breaking_with_icu/' \
	src/qt/src/3rdparty/webkit/Source/JavaScriptCore/JavaScriptCore.pri
}

src_compile() {
	./build.sh --confirm --qt-config $(pkg-config --cflags-only-I freetype2) || die
}

src_test() {
	./bin/phantomjs test/run-tests.js || die
}

src_install() {
	dobin bin/phantomjs || die
	dodoc ChangeLog README.md
	if use examples ; then
		docinto examples
		dodoc examples/* || die
	fi
}
