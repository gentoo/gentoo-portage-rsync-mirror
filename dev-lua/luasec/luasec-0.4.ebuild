# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luasec/luasec-0.4.ebuild,v 1.3 2012/05/04 04:01:51 jdhore Exp $

EAPI=2

inherit multilib toolchain-funcs flag-o-matic eutils

DESCRIPTION="Lua binding for OpenSSL library to provide TLS/SSL communication."
HOMEPAGE="http://www.inf.puc-rio.br/~brunoos/luasec/"
SRC_URI="http://www.inf.puc-rio.br/~brunoos/luasec/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/lua-5.1[deprecated]
		dev-lua/luasocket
		dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i -e "s#^LUAPATH=.*#LUAPATH=$(pkg-config --variable INSTALL_LMOD lua)#" "${S}/Makefile"
	sed -i -e "s#^LUACPATH=.*#LUACPATH=$(pkg-config --variable INSTALL_CMOD lua)#" "${S}/Makefile"
	epatch "${FILESDIR}/${P}_Makefile.patch"
}

src_compile() {
	append-flags -fPIC
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC) -shared" \
		linux \
		|| die
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
