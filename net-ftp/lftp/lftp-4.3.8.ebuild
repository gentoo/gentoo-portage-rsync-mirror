# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-4.3.8.ebuild,v 1.9 2012/09/11 15:50:19 armin76 Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A sophisticated ftp/sftp/http/https/torrent client and file transfer program"
HOMEPAGE="http://lftp.yar.ru/"
SRC_URI="http://ftp.yars.free.net/pub/source/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~sparc-fbsd ~x86-fbsd"

LFTP_LINGUAS="cs de es fr it ja ko pl pt_BR ru zh_CN zh_HK zh_TW"

IUSE="
	$( for i in ${LFTP_LINGUAS}; do echo linguas_${i}; done )
	gnutls nls socks5 +ssl
"

RDEPEND="
	dev-libs/expat
	>=sys-libs/ncurses-5.1
	socks5? (
		>=net-proxy/dante-1.1.12
		virtual/pam )
	ssl? (
		gnutls? ( >=net-libs/gnutls-1.2.3 )
		!gnutls? ( >=dev-libs/openssl-0.9.6 )
	)
	>=sys-libs/readline-5.1
"

DEPEND="
	${RDEPEND}
	=sys-devel/libtool-2*
	app-arch/xz-utils
	dev-lang/perl
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

DOCS=(
	BUGS ChangeLog FAQ FEATURES MIRRORS NEWS README  README.debug-levels
	README.dnssec  README.modules THANKS TODO
)

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-4.0.2.91-lafile.patch" \
		"${FILESDIR}/${PN}-4.0.3-autoconf-2.64.patch" \
		"${FILESDIR}/${PN}-4.3.5-autopoint.patch" \
		"${FILESDIR}/${PN}-4.3.8-gets.patch"
	eautoreconf
}

src_configure() {
	local myconf=""

	if use ssl && use gnutls ; then
		myconf="${myconf} --without-openssl"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --without-gnutls --with-openssl=/usr"
	else
		myconf="${myconf} --without-gnutls --without-openssl"
	fi

	use socks5 && myconf="${myconf} --with-socksdante=/usr" \
		|| myconf="${myconf} --without-socksdante"

	econf \
		--enable-packager-mode \
		--sysconfdir=/etc/lftp \
		--with-modules \
		$(use_enable nls) \
		${myconf}
}
