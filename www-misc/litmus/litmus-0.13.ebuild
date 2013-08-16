# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/litmus/litmus-0.13.ebuild,v 1.1 2013/08/16 21:44:02 tomwij Exp $

EAPI="5"

# TODO: FAIL (connection refused by '...' port 80: Connection refused)
RESTRICT="test"

DESCRIPTION="WebDAV server protocol compliance test suite"
HOMEPAGE="http://www.webdav.org/neon/litmus"
SRC_URI="http://www.webdav.org/neon/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug gnutls gssapi libproxy openssl pkcs11"

REQUIRED_USE="openssl? ( !gnutls ) gnutls? ( !openssl )"

neon_dep="<net-libs/neon-0.30:0/0"

# First paragraph are required dependencies, second optional. 
DEPEND="
	gnutls? ( ${neon_dep}[ssl,zlib] )
	openssl? ( ${neon_dep}[ssl,zlib] )
	!gnutls? ( !openssl? ( ${neon_dep}[zlib] ) )
	|| ( dev-libs/expat:0 dev-libs/libxml2:2 )

	gnutls? ( net-libs/gnutls:0 )
	gssapi? ( dev-perl/GSSAPI:0 )
	libproxy? ( net-libs/libproxy:0 )
	pkcs11? ( dev-libs/pakchois:0 )
	openssl? ( dev-libs/openssl:0 )"

RDEPEND="${DEPEND}"

DOCS=( ChangeLog FAQ NEWS README THANKS TODO )

src_configure() {
	# TODO: No EGD in the Portage tree for --with-egd.
	econf \
		$(use_with gnutls ssl gnutls) \
		$(use_with gssapi) \
		$(use_with libproxy) \
		$(use_with openssl ssl openssl) \
		$(use_with pkcs11 pakchois) \
		$(use_enable debug) \
		--with-neon \
		--without-included-neon
}
