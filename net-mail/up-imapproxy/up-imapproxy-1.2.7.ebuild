# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.7.ebuild,v 1.3 2011/11/28 11:41:27 phajdan.jr Exp $

EAPI=4

inherit eutils

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
SRC_URI="mirror://sourceforge/squirrelmail/squirrelmail-imap_proxy-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="kerberos ssl +tcpd"

RDEPEND="sys-libs/ncurses
	kerberos? ( virtual/krb5 )
	ssl? ( dev-libs/openssl )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/squirrelmail-imap_proxy-${PV}

src_prepare() {
	epatch "${FILESDIR}/${P}"-ldflags.patch
	sed -i -e 's:in\.imapproxyd:imapproxyd:g' \
		README Makefile.in include/imapproxy.h || die "sed failed"

	#buffer oveflow
	#http://lists.andrew.cmu.edu/pipermail/imapproxy-info/2010-June/000874.html
	sed -i \
		-e "/define BUFSIZE/s/4096/8192/" \
		-e "/define MAXPASSWDLEN/s/64/8192/" \
		include/imapproxy.h
}

src_configure() {
	econf \
		$(use_with kerberos krb5) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap)
}

src_install() {
	dosbin bin/imapproxyd bin/pimpstat

	insinto /etc
	doins scripts/imapproxy.conf

	newinitd "${FILESDIR}"/imapproxy.initd imapproxy

	dodoc ChangeLog README README.known_issues
	use ssl && dodoc README.ssl

	doman "${FILESDIR}"/*.8
}
