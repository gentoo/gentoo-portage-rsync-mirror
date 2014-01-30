# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-sipe/pidgin-sipe-1.18.0.ebuild,v 1.1 2014/01/30 22:09:01 thev00d00 Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug kerberos nss ocs2005-message-hack openssl telepathy voice"
REQUIRED_USE="^^ ( openssl nss )"

RDEPEND=">=dev-libs/gmime-2.4.16
	dev-libs/libxml2
	nss? ( dev-libs/nss )
	openssl? ( dev-libs/openssl )
	kerberos? ( virtual/krb5 )
	voice? (
		>=dev-libs/glib-2.28.0
		>=net-libs/libnice-0.1.0
		media-libs/gstreamer:0.10
		>=net-im/pidgin-2.8.0
	)
	!voice? (
		>=dev-libs/glib-2.12.0:2
		net-im/pidgin
	)
	telepathy? (
		>=sys-apps/dbus-1.1.0
		>=dev-libs/dbus-glib-0.61
		>=dev-libs/glib-2.28:2
		>=net-libs/telepathy-glib-0.18.0
	)
"

DEPEND="dev-util/intltool
	virtual/pkgconfig
	${RDEPEND}
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.13.2-fix-sandbox-r1.patch"
	eautoreconf
}

src_configure() {
	econf \
		--enable-purple \
		--disable-quality-check \
		$(use_enable telepathy) \
		$(use_enable debug) \
		$(use_enable ocs2005-message-hack) \
		$(use_with kerberos krb5) \
		$(use_with voice vv) \
		$(use_enable openssl) \
		$(use_enable nss)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS TODO README
}
