# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/prosody/prosody-0.9.1-r1.ebuild,v 1.3 2014/01/27 02:21:51 zx2c4 Exp $

EAPI=5

inherit flag-o-matic multilib versionator toolchain-funcs

MY_PV=$(replace_version_separator 3 '')
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Prosody is a flexible communications server for Jabber/XMPP written in Lua."
HOMEPAGE="http://prosody.im/"
SRC_URI="http://prosody.im/tmp/${MY_PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="ipv6 libevent mysql postgres sqlite ssl zlib"

DEPEND="net-im/jabber-base
		>=dev-lang/lua-5.1
		>=net-dns/libidn-1.1
		>=dev-libs/openssl-0.9.8"
RDEPEND="${DEPEND}
		dev-lua/luaexpat
		dev-lua/luafilesystem
		ipv6? ( >=dev-lua/luasocket-3 )
		!ipv6? ( dev-lua/luasocket )
		libevent? ( >=dev-lua/luaevent-0.4.3 )
		mysql? ( dev-lua/luadbi[mysql] )
		postgres? ( dev-lua/luadbi[postgres] )
		sqlite? ( dev-lua/luadbi[sqlite] )
		ssl? ( dev-lua/luasec )
		zlib? ( dev-lua/lua-zlib )"

S=${WORKDIR}/${MY_P}

JABBER_ETC="/etc/jabber"
JABBER_SPOOL="/var/spool/jabber"

src_prepare() {
	sed -i -e "s!MODULES = \$(DESTDIR)\$(PREFIX)/lib/!MODULES = \$(DESTDIR)\$(PREFIX)/$(get_libdir)/!"\
		-e "s!SOURCE = \$(DESTDIR)\$(PREFIX)/lib/!SOURCE = \$(DESTDIR)\$(PREFIX)/$(get_libdir)/!"\
		-e "s!INSTALLEDSOURCE = \$(PREFIX)/lib/!INSTALLEDSOURCE = \$(PREFIX)/$(get_libdir)/!"\
		-e "s!INSTALLEDMODULES = \$(PREFIX)/lib/!INSTALLEDMODULES = \$(PREFIX)/$(get_libdir)/!"\
		 Makefile || die
}

src_configure() {
	# the configure script is handcrafted (and yells at unknown options)
	# hence do not use 'econf'
	append-cflags -D_GNU_SOURCE
	./configure \
		--ostype=linux \
		--prefix="/usr" \
		--sysconfdir="${JABBER_ETC}" \
		--datadir="${JABBER_SPOOL}" \
		--with-lua-include=/usr/include \
		--with-lua-lib=/usr/$(get_libdir)/lua \
		--cflags="${CFLAGS} -Wall -fPIC" \
		--ldflags="${LDFLAGS} -shared" \
		--c-compiler="$(tc-getCC)" \
		--linker="$(tc-getCC)" \
		--require-config || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install
	newinitd "${FILESDIR}/${PN}".initd.old ${PN}
}

src_test() {
	cd tests || die
	./run_tests.sh || die
}
