# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.6.ebuild,v 1.3 2009/06/03 18:54:33 maekke Exp $

EAPI=2
inherit eutils

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
SRC_URI="http://www.imapproxy.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="kerberos ssl +tcpd"

RDEPEND="sys-libs/ncurses
	kerberos? ( virtual/krb5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_prepare() {
	epatch "${FILESDIR}"/${P}-debian_patchset_5_and_security_fix.patch
	sed -i -e 's:in\.imapproxyd:imapproxyd:g' \
		README Makefile.in include/imapproxy.h || die "sed failed"
}

src_configure() {
	econf \
		$(use_with kerberos krb5) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap)
}

src_install() {
	dosbin bin/imapproxyd bin/pimpstat || die "dosbin failed"

	insinto /etc
	doins scripts/imapproxy.conf || die "doins failed"

	newinitd "${FILESDIR}"/imapproxy.initd imapproxy || die "newinitd failed"

	dodoc ChangeLog README README.known_issues
	use ssl && dodoc README.ssl

	doman "${FILESDIR}"/*.8
}
