# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luasocket/luasocket-3.0_rc1.ebuild,v 1.1 2013/09/11 15:09:53 mrueg Exp $

EAPI=5

inherit multilib flag-o-matic

DESCRIPTION="Networking support library for the Lua language."
HOMEPAGE="http://www.tecgraf.puc-rio.br/~diego/professional/luasocket/"
SRC_URI="https://github.com/diegonehab/${PN}/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/lua-5.1[deprecated]"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${PV/_/-}

src_compile() {
	emake \
		CC="$(tc-getCC) ${CFLAGS}" \
		LD="$(tc-getCC) ${LDFLAGS}"\
		$(usex debug DEBUG="DEBUG")
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LUAPREFIX_linux=/usr \
		LUAV=5.1 \
		CDIR_linux=$(get_libdir)/lua/${LUAV} \
		install
	dodoc NEW README
	dohtml doc/*
}
