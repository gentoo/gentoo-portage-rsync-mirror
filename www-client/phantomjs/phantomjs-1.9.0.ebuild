# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/phantomjs/phantomjs-1.9.0.ebuild,v 1.4 2013/04/25 22:16:43 zx2c4 Exp $

EAPI=5

inherit toolchain-funcs pax-utils

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
	# Respect CC, CXX, {C,CXX,LD}FLAGS in .qmake.cache
	sed -e "/^SYSTEM_VARIABLES=/i \
		CC='$(tc-getCC)'\n\
		CXX='$(tc-getCXX)'\n\
		CFLAGS='${CFLAGS}'\n\
		CXXFLAGS='${CXXFLAGS}'\n\
		LDFLAGS='${LDFLAGS}'\n\
		QMakeVar set QMAKE_CFLAGS_RELEASE\n\
		QMakeVar set QMAKE_CFLAGS_DEBUG\n\
		QMakeVar set QMAKE_CXXFLAGS_RELEASE\n\
		QMakeVar set QMAKE_CXXFLAGS_DEBUG\n\
		QMakeVar set QMAKE_LFLAGS_RELEASE\n\
		QMakeVar set QMAKE_LFLAGS_DEBUG\n"\
		-i src/qt/configure \
		|| die "sed SYSTEM_VARIABLES failed"

	# Respect CC, CXX, LINK and *FLAGS in config.tests
	find src/qt/config.tests/unix -name '*.test' -type f -print0 | xargs -0 \
		sed -i -e "/bin\/qmake/ s: \"\$SRCDIR/: \
			'QMAKE_CC=$(tc-getCC)'    'QMAKE_CXX=$(tc-getCXX)'      'QMAKE_LINK=$(tc-getCXX)' \
			'QMAKE_CFLAGS+=${CFLAGS}' 'QMAKE_CXXFLAGS+=${CXXFLAGS}' 'QMAKE_LFLAGS+=${LDFLAGS}'&:" \
		|| die "sed config.tests failed"
}

src_compile() {
	./build.sh --confirm --qt-config $(pkg-config --cflags-only-I freetype2) || die
}

src_test() {
	./bin/phantomjs test/run-tests.js || die
}

src_install() {
	pax-mark m bin/phantomjs || die
	dobin bin/phantomjs || die
	dodoc ChangeLog README.md
	if use examples ; then
		docinto examples
		dodoc examples/* || die
	fi
}
