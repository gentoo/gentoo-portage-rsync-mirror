# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/nufw/nufw-2.2.22.ebuild,v 1.4 2014/03/01 22:49:17 mgorny Exp $

EAPI=1
SSL_CERT_MANDATORY=1

inherit ssl-cert eutils pam

DESCRIPTION="An enterprise grade authenticating firewall based on netfilter"
HOMEPAGE="http://www.nufw.org/"
SRC_URI="http://www.nufw.org/attachments/download/39/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug ldap mysql pam pam_nuauth plaintext postgres prelude \
unicode nfqueue nfconntrack static syslog test"

DEPEND=">=dev-libs/glib-2
	dev-libs/libgcrypt:0
	>=dev-libs/cyrus-sasl-2
	net-firewall/iptables
	>=net-libs/gnutls-1.1
	ldap? ( >=net-nds/openldap-2 )
	mysql? ( virtual/mysql )
	pam? ( sys-libs/pam )
	pam_nuauth? ( sys-libs/pam )
	postgres? ( dev-db/postgresql-server )
	nfqueue? ( net-libs/libnfnetlink
		net-libs/libnetfilter_queue )
	nfconntrack? ( net-libs/libnetfilter_conntrack )
	prelude? ( dev-libs/libprelude )
	dev-python/ipy"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:^#\(nuauth_tls_key="/etc/nufw/\)nuauth-key.pem:\1nuauth.key:' \
		-e 's:^#\(nuauth_tls_cert="/etc/nufw/\)nuauth-cert.pem:\1nuauth.pem:' \
		conf/nuauth.conf || die "sed failed"
}

src_compile() {
	econf \
		--with-shared \
		$(use_enable static) \
		$(use_enable pam_nuauth pam-nufw) \
		$(use_with prelude prelude-log) \
		$(use_with mysql mysql-log) \
		$(use_with mysql mysql-auth) \
		$(use_with postgres pgsql-log) \
		$(use_with syslog syslog-log) \
		$(use_with plaintext plaintext-auth) \
		--with-mark-group \
		$(use_with pam system-auth) \
		$(use_with ldap) \
		$(use_with nfqueue) \
		$(use_with nfconntrack) \
		$(use_with unicode utf8) \
		$(use_enable debug) \
		--with-user-mark \
		--sysconfdir="/etc/nufw" \
		--localstatedir="/var" \
		--includedir="/usr/include/nufw" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	ewarn "Tests are skiped! They require root privileges."
	true
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/nufw-init.d nufw
	newconfd "${FILESDIR}"/nufw-conf.d nufw

	newinitd "${FILESDIR}"/nuauth-init.d nuauth
	newconfd "${FILESDIR}"/nuauth-conf.d nuauth

	insinto /etc/nufw
	doins conf/nuauth.conf
	keepdir /var/run/nuauth

	dodoc AUTHORS ChangeLog NEWS README TODO
	docinto scripts
	dodoc scripts/{clean_conntrack.pl,nuaclgen,nutop,README,ulog_rotate_daily.sh,ulog_rotate_weekly.sh}
	docinto conf
	dodoc conf/*.{nufw,schema,conf,dump,xml}

	if use pam; then
		pamd_mimic system-auth nufw auth account password session
	fi
}

pkg_postinst() {
	install_cert /etc/nufw/{nufw,nuauth}
}
