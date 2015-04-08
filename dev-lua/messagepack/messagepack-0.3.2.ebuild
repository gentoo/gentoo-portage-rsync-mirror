# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/messagepack/messagepack-0.3.2.ebuild,v 1.1 2015/02/26 05:33:29 yngwin Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="A pure Lua implementation of the MessagePack serialization format"
HOMEPAGE="http://fperrad.github.io/lua-MessagePack/"
SRC_URI="http://dev.gentoo.org/~yngwin/distfiles/lua-${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+luajit"

RDEPEND="luajit? ( dev-lang/luajit:2 )
	!luajit? ( dev-lang/lua:= )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	local lua=lua
	use luajit && lua=luajit
	insinto "$($(tc-getPKG_CONFIG) --variable INSTALL_LMOD ${lua})"
	doins src/MessagePack.lua
	dodoc CHANGES README.md
}
