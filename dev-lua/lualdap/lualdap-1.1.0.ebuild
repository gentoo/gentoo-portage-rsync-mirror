# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/lualdap/lualdap-1.1.0.ebuild,v 1.1 2015/02/24 10:05:41 chainsaw Exp $

EAPI=5

inherit eutils toolchain-funcs

MY_PN="LuaLDAP"

DESCRIPTION="Simple interface from Lua to an LDAP client"
HOMEPAGE="http://www.keplerproject.org/lualdap"
SRC_URI="http://files.luaforge.net/releases/${PN}/${PN}/${MY_PN}${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="dev-lang/lua:*"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}-destdir.patch"
	epatch "${FILESDIR}/${P}-lua-5.1.patch"
	epatch "${FILESDIR}/${P}-openldap-2.3.patch"
}

src_configure() {
	sed -i config \
		-e "s:LUA_VERSION_NUM=.*:LUA_VERSION_NUM=501:" \
		-e "s:LUA_LIBDIR=.*:LUA_LIBDIR=$(pkg-config --variable=INSTALL_CMOD lua):" \
		-e "s:LUA_INC=.*:LUA_INC=$(pkg-config --variable=INSTALL_INC lua):" \
		-e "s:OPENLDAP_INC=.*:OPENLDAP_INC=/usr/include:" \
		-e "s:CFLAGS=.*:CFLAGS=${CFLAGS} ${LDFLAGS} -fPIC -Wall -ansi \$(INCS):" \
		-e "s:CC=.*:CC=$(tc-getCC):" \
		|| die "Failed to customise configure script"
}
