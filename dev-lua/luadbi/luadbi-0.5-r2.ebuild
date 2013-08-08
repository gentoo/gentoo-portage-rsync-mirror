# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luadbi/luadbi-0.5-r2.ebuild,v 1.4 2013/08/08 19:25:05 maekke Exp $

EAPI=5

inherit multilib toolchain-funcs flag-o-matic eutils

DESCRIPTION="DBI module for Lua"
HOMEPAGE="http://code.google.com/p/luadbi/"
SRC_URI="http://luadbi.googlecode.com/files/${PN}.${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="mysql postgres sqlite"
REQUIRED_USE="|| ( mysql postgres sqlite )"

RDEPEND=">=dev-lang/lua-5.1
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-base )
		sqlite? ( >=dev-db/sqlite-3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}/${PVR}-Makefile.patch"
	epatch "${FILESDIR}/${PV}-postgres-path.patch"
	sed -i -e "s#^INSTALL_DIR_LUA=.*#INSTALL_DIR_LUA=$(pkg-config --variable INSTALL_LMOD lua)#" "${S}/Makefile"
	sed -i -e "s#^INSTALL_DIR_BIN=.*#INSTALL_DIR_BIN=$(pkg-config --variable INSTALL_CMOD lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_INC_DIR=.*#LUA_INC_DIR=$(pkg-config --variable INSTALL_INC lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_LIB_DIR=.*#LUA_LIB_DIR=$(pkg-config --variable INSTALL_LIB lua)#" "${S}/Makefile"
	sed -i -e "s#^LUA_LIB =.*#LUA_LIB=lua#" "${S}/Makefile"
}

src_compile() {
	local drivers=""
	use mysql && drivers="${drivers} mysql"
	use postgres && drivers="${drivers} psql"
	use sqlite && drivers="${drivers} sqlite3"

	append-flags -fPIC
	for driver in "${drivers}" ; do
		emake CC="$(tc-getCC)" COMMON_LDFLAGS="${LDFLAGS}" ${driver}
	done
}

src_install() {
	local drivers=""
	use mysql && drivers="${drivers} mysql"
	use postgres && drivers="${drivers} psql"
	use sqlite && drivers="${drivers} sqlite3"

	for driver in ${drivers} ; do
		emake DESTDIR="${D}" "install_${driver// /}"
	done
}
