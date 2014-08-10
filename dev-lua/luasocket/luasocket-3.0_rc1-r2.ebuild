# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luasocket/luasocket-3.0_rc1-r2.ebuild,v 1.6 2014/08/10 20:42:11 slyfox Exp $

EAPI=5

inherit multilib flag-o-matic

DESCRIPTION="Networking support library for the Lua language"
HOMEPAGE="http://www.tecgraf.puc-rio.br/~diego/professional/luasocket/"
SRC_URI="https://github.com/diegonehab/${PN}/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~mips x86"
IUSE="debug"

RDEPEND=">=dev-lang/lua-5.1[deprecated]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}-${PV/_/-}

RESTRICT="test"

src_compile() {
	emake \
		CC="$(tc-getCC) ${CFLAGS}" \
		LD="$(tc-getCC) ${LDFLAGS}"\
		$(usex debug DEBUG="DEBUG" "")
}

src_install() {
	local luav=$(pkg-config --variable V lua)
	emake \
		DESTDIR="${D}" \
		LUAPREFIX_linux=/usr \
		LUAV=${luav} \
		CDIR_linux=$(get_libdir)/lua/${luav} \
		install-unix
	dodoc NEW README
	dohtml doc/*
}
