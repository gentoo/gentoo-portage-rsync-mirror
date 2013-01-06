# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/lua-zlib/lua-zlib-0.2.ebuild,v 1.4 2012/09/28 17:05:46 johu Exp $

EAPI=3

inherit cmake-utils

DESCRIPTION="Lua bindings to zlib"
HOMEPAGE="http://github.com/brimworks/lua-zlib"
SRC_URI="https://github.com/brimworks/${PN}/tarball/v${PV} -> ${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/lua
		sys-libs/zlib"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_configure() {
	MYCMAKEARGS="-DINSTALL_CMOD='$(pkg-config --variable INSTALL_CMOD lua)'"
	cmake-utils_src_configure
}
