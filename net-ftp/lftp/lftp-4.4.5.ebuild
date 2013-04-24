# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/lftp/lftp-4.4.5.ebuild,v 1.12 2013/04/24 14:27:01 jer Exp $

EAPI=5
inherit autotools eutils libtool

DESCRIPTION="A sophisticated ftp/sftp/http/https/torrent client and file transfer program"
HOMEPAGE="http://lftp.yar.ru/"
SRC_URI="ftp://ftp.yars.free.net/pub/source/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"

IUSE="gnutls nls socks5 +ssl"
LFTP_LINGUAS=( cs de es fr it ja ko pl pt_BR ru zh_CN zh_HK zh_TW )
IUSE+=" ${LFTP_LINGUAS[@]/#/linguas_}"

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
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

DOCS=(
	BUGS ChangeLog FAQ FEATURES MIRRORS NEWS README  README.debug-levels
	README.dnssec  README.modules THANKS TODO
)

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-4.0.2.91-lafile.patch" \
		"${FILESDIR}/${PN}-4.3.5-autopoint.patch" \
		"${FILESDIR}/${PN}-4.3.8-gets.patch"
	sed -i configure.ac -e 's|^AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' || die
	eautoreconf
	elibtoolize # for Darwin bundles
}

src_configure() {
	local myconf=""

	if use ssl && use gnutls ; then
		myconf="${myconf} --without-openssl"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf} --without-gnutls --with-openssl=${EPREFIX}/usr"
	else
		myconf="${myconf} --without-gnutls --without-openssl"
	fi

	use socks5 && myconf="${myconf} --with-socksdante=${EPREFIX}/usr" \
		|| myconf="${myconf} --without-socksdante"

	econf \
		$(use_enable nls) \
		${myconf} \
		--enable-packager-mode \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--with-modules \
		--without-included-regex
}
