# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luacrypto/luacrypto-0.3.2.ebuild,v 1.1 2013/05/08 23:29:36 radhermit Exp $

EAPI=5

inherit cmake-utils multilib

DESCRIPTION="Lua frontend to OpenSSL"
HOMEPAGE="http://mkottman.github.io/luacrypto/ https://github.com/mkottman/luacrypto/"
SRC_URI="https://github.com/mkottman/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/lua-5.1
	dev-libs/openssl:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-test.patch )

DOCS=( ChangeLog README )

src_configure() {
	local mycmakeargs=(
		"-DSKIP_INSTALL_DATA=ON"
		"-DINSTALL_LMOD=$(pkg-config --variable INSTALL_LMOD lua)"
		"-DINSTALL_CMOD=$(pkg-config --variable INSTALL_CMOD lua)"
	)
	cmake-utils_src_configure
}

src_test() {
	cp tests/message "${BUILD_DIR}" || die
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml doc/us/*
}
