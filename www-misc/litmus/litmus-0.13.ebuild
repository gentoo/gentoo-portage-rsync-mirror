# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/litmus/litmus-0.13.ebuild,v 1.2 2013/09/01 18:26:28 tomwij Exp $

EAPI="5"

# TODO: FAIL (connection refused by '...' port 80: Connection refused)
# We can't run tests that connect with the internet.
RESTRICT="test"

DESCRIPTION="WebDAV server protocol compliance test suite"
HOMEPAGE="http://www.webdav.org/neon/litmus"
SRC_URI="http://www.webdav.org/neon/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug gnutls kerberos libproxy ssl pkcs11 threads"

REQUIRED_USE="^^ ( ssl gnutls )"

neon_dep="<net-libs/neon-0.30:0/0"

# First paragraph are required dependencies, second optional.
DEPEND="
	gnutls? ( ${neon_dep}[ssl,zlib] )
	ssl? ( ${neon_dep}[ssl,zlib] )
	!gnutls? ( !ssl? ( ${neon_dep}[zlib] ) )
	|| ( dev-libs/expat:0 dev-libs/libxml2:2 )

	gnutls? ( net-libs/gnutls:0 )
	kerberos? ( dev-perl/GSSAPI:0 )
	libproxy? ( net-libs/libproxy:0 )
	pkcs11? ( dev-libs/pakchois:0 )
	ssl? ( dev-libs/openssl:0 )"

RDEPEND="${DEPEND}"

DOCS=( ChangeLog FAQ NEWS README THANKS TODO )

src_configure() {
	# No EGD available in the Portage tree.
	econf \
		--enable-warnings \
		--without-egd \
		--with-neon \
		--without-included-neon \
		$(use_enable debug) \
		$(use_enable threads threadsafe-ssl posix) \
		$(use_with gnutls ssl gnutls) \
		$(use_with kerberos gssapi) \
		$(use_with libproxy) \
		$(use_with ssl ssl openssl) \
		$(use_with pkcs11 pakchois)
}
