# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/prosody/prosody-0.8.2.ebuild,v 1.6 2014/01/27 02:21:51 zx2c4 Exp $

EAPI="2"

inherit eutils multilib toolchain-funcs versionator

MY_PV=$(replace_version_separator 3 '')
DESCRIPTION="Prosody is a flexible communications server for Jabber/XMPP written in Lua."
HOMEPAGE="http://prosody.im/"
SRC_URI="http://prosody.im/downloads/source/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="libevent mysql postgres sqlite ssl zlib"

DEPEND="net-im/jabber-base
		>=dev-lang/lua-5.1
		>=net-dns/libidn-1.1
		>=dev-libs/openssl-0.9.8"
RDEPEND="${DEPEND}
		dev-lua/luasocket
		ssl? ( dev-lua/luasec )
		dev-lua/luaexpat
		dev-lua/luafilesystem
		mysql? ( >=dev-lua/luadbi-0.5[mysql] )
		postgres? ( >=dev-lua/luadbi-0.5[postgres] )
		sqlite? ( >=dev-lua/luadbi-0.5[sqlite] )
		libevent? ( dev-lua/luaevent )
		zlib? ( dev-lua/lua-zlib )"

S="${WORKDIR}/${PN}-${MY_PV}"

JABBER_ETC="/etc/jabber"
JABBER_SPOOL="/var/spool/jabber"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.8.0-cfg.lua.patch"
	sed -i "s!MODULES = \$(DESTDIR)\$(PREFIX)/lib/!MODULES = \$(DESTDIR)\$(PREFIX)/$(get_libdir)/!" Makefile
	sed -i "s!SOURCE = \$(DESTDIR)\$(PREFIX)/lib/!SOURCE = \$(DESTDIR)\$(PREFIX)/$(get_libdir)/!" Makefile
	sed -i "s!INSTALLEDSOURCE = \$(PREFIX)/lib/!INSTALLEDSOURCE = \$(PREFIX)/$(get_libdir)/!" Makefile
	sed -i "s!INSTALLEDMODULES = \$(PREFIX)/lib/!INSTALLEDMODULES = \$(PREFIX)/$(get_libdir)/!" Makefile
}

src_configure() {
	# the configure script is handcrafted (and yells at unknown options)
	# hence do not use 'econf'
	./configure --prefix="/usr" \
		--sysconfdir="${JABBER_ETC}" \
		--datadir="${JABBER_SPOOL}" \
		--with-lua-lib=/usr/$(get_libdir)/lua \
		--c-compiler="$(tc-getCC)" --linker="$(tc-getCC)" \
		--cflags="${CFLAGS} -Wall -fPIC" \
		--ldflags="${LDFLAGS} -shared" \
		--require-config || die "configure failed"
}

src_install() {
	DESTDIR="${D}" emake install || die "make failed"
	newinitd "${FILESDIR}/${PN}".initd.old ${PN}
}

src_test() {
	cd tests
	./run_tests.sh
}

pkg_postinst() {
	elog "Please note that the module 'console' has been renamed to 'admin_telnet'."
}
