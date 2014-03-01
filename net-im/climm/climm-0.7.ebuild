# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/climm/climm-0.7.ebuild,v 1.4 2014/03/01 22:34:58 mgorny Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="ICQ text-mode client with many features"
HOMEPAGE="http://www.climm.org/"
SRC_URI="http://www.climm.org/source/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="jabber gnutls otr tcl ssl"

# In case user don't need jabber there is a choice gnutls/openssl. Since jabber
# requires gnutls then without explicit request to use gnutls (USE=gnutls)
# for ssl we fall back on gnutls instead of openssl.
RDEPEND="jabber? ( || ( >=dev-libs/iksemel-1.4[ssl] >=dev-libs/iksemel-1.3[gnutls] ) )
	ssl? ( gnutls? ( >=net-libs/gnutls-0.8.10
					dev-libs/libgcrypt:0 )
			!gnutls? ( !jabber? ( dev-libs/openssl )
						jabber? ( >=net-libs/gnutls-0.8.10 ) ) )
	tcl? ( dev-lang/tcl )
	otr? ( >=net-libs/libotr-3.0.0 )"
DEPEND="${RDEPEND}
	ssl? ( gnutls? ( virtual/pkgconfig )
			!gnutls? ( jabber? ( virtual/pkgconfig ) ) )"

src_prepare() {
	epatch "${FILESDIR}/${P}-gnutls.patch"
	eautoconf
}

src_configure() {
	local myconf
	if use ssl; then
		myconf="--enable-ssl"
		if use gnutls; then
			einfo "Using gnutls"
			myconf="--enable-ssl=gnutls"
		else
			if use jabber; then
				einfo "Using gnutls (required for jabber/XMPP)"
				myconf="--enable-ssl=gnutls"
			else
				einfo "Using openSSL"
				myconf="--enable-ssl=openssl"
			fi
		fi
	else
		if use jabber; then
			einfo "Using gnutls (required for jabber/XMPP)"
			myconf="--enable-ssl=gnutls"
		else
			myconf="--disable-ssl"
		fi
	fi

	econf \
		$(use_enable jabber xmpp) \
		$(use_enable otr) \
		$(use_enable tcl) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README TODO
}
