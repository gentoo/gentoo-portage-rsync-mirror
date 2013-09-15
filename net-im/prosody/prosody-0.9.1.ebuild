# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/prosody/prosody-0.9.1.ebuild,v 1.1 2013/09/15 10:07:44 klausman Exp $

EAPI="5"

inherit flag-o-matic multilib versionator

MY_PV=$(replace_version_separator 3 '')
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Prosody is a flexible communications server for Jabber/XMPP written in Lua."
HOMEPAGE="http://prosody.im/"
SRC_URI="http://prosody.im/tmp/${MY_PV}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="libevent mysql postgres sqlite ssl zlib"

DEPEND="net-im/jabber-base
		>=dev-lang/lua-5.1
		>=net-dns/libidn-1.1
		>=dev-libs/openssl-0.9.8"
RDEPEND="${DEPEND}
		dev-lua/luaexpat
		dev-lua/luafilesystem
		>=dev-lua/luasocket-3
		libevent? ( >=dev-lua/luaevent-0.4.3 )
		mysql? ( dev-lua/luadbi[mysql] )
		postgres? ( dev-lua/luadbi[postgres] )
		sqlite? ( dev-lua/luadbi[sqlite] )
		ssl? ( dev-lua/luasec )
		zlib? ( dev-lua/lua-zlib )"

S="${WORKDIR}/${MY_P}"

JABBER_ETC="/etc/jabber"
JABBER_SPOOL="/var/spool/jabber"

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
	newinitd "${FILESDIR}/${PN}".initd ${PN}
}

src_test() {
	cd tests
	./run_tests.sh
}
