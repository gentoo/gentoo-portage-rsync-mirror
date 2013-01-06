# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/yafc/yafc-1.1.2.ebuild,v 1.3 2011/04/29 15:13:37 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Console ftp client with a lot of nifty features"
HOMEPAGE="http://yafc.sourceforge.net/"
SRC_URI="http://github.com/downloads/cpages/yafc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="readline kerberos socks5"

DEPEND="readline? ( >=sys-libs/readline-6 )
	kerberos? ( virtual/krb5 )
	socks5? ( net-proxy/dante )"
RDEPEND="${DEPEND}
	>=net-misc/openssh-3"

src_configure() {
	local myconf=""

	if use kerberos; then
		if has_version app-crypt/heimdal; then
			myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
		elif has_version app-crypt/mit-krb5; then
			myconf="${myconf} --with-krb5=/usr/ --with-krb4=no --with-gssapi=/usr"
		else
			ewarn "No supported kerberos providers detected"
			myconf="${myconf} --without-krb4 --without-krb5"
		fi
	else
		myconf="${myconf} --without-krb4 --without-krb5"
	fi

	use socks5 && myconf="${myconf} --with-socks5=/usr" \
		|| myconf="${myconf} --with-socks5=no"

	use readline && myconf="${myconf} --with-readline=/usr" \
		|| myconf="${myconf} --with-readline=no"

	econf \
		$(use_with readline) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc BUGS NEWS README THANKS TODO *.sample || die
}
