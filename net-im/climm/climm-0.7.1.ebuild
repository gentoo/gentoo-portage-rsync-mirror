# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/climm/climm-0.7.1.ebuild,v 1.2 2012/05/04 06:22:13 jdhore Exp $

EAPI="4"

DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.climm.org/"
SRC_URI="http://www.climm.org/source/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jabber gnutls otr tcl ssl"

# In case user don't need jabber there is a choice gnutls/openssl. Since jabber
# requires gnutls then without explicit request to use gnutls (USE=gnutls)
# for ssl we fall back on gnutls instead of openssl.
REQUIRED_USE="jabber? ( ssl gnutls )"

RDEPEND="jabber? ( || ( >=dev-libs/iksemel-1.4[ssl] >=dev-libs/iksemel-1.3[gnutls] ) )
	ssl? ( gnutls? ( >=net-libs/gnutls-0.8.10
					dev-libs/libgcrypt )
			!gnutls? ( dev-libs/openssl ) )
	tcl? ( dev-lang/tcl )
	otr? ( >=net-libs/libotr-3.0.0 )"
DEPEND="${RDEPEND}
	ssl? ( gnutls? ( virtual/pkgconfig ) )"

src_configure() {
	local myconf
	if use ssl; then
		if use gnutls; then
			einfo "Using gnutls"
			myconf="--enable-ssl=gnutls"
		else
			einfo "Using openSSL"
			myconf="--enable-ssl=openssl"
		fi
	else
		myconf="--disable-ssl"
	fi

	econf \
		$(use_enable jabber xmpp) \
		$(use_enable otr) \
		$(use_enable tcl) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
