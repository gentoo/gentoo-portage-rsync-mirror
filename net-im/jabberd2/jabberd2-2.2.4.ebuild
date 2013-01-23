# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd2/jabberd2-2.2.4.ebuild,v 1.7 2013/01/23 11:41:03 pinkbyte Exp $

inherit db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.org"
SRC_URI="http://ftp.xiaoka.com/${PN}/releases/jabberd-${PV}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="berkdb debug memdebug mysql ldap pam postgres sqlite ssl zlib"

DEPEND="dev-libs/expat
	net-libs/udns
	>=net-dns/libidn-0.3
	virtual/gsasl
	berkdb? ( >=sys-libs/db-4.1.25 )
	mysql? ( virtual/mysql )
	ldap? ( >=net-nds/openldap-2.1.0 )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql-base )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	sqlite? ( >=dev-db/sqlite-3 )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	>=net-im/jabber-base-0.01
	!net-im/jabberd"

S="${WORKDIR}/jabberd-${PV}"

src_compile() {

	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	use berkdb && myconf="${myconf} --with-extra-include-path=$(db_includedir)"

	if use debug; then
		myconf="${myconf} --enable-debug"
		# --enable-pool-debug is currently broken
		use memdebug && myconf="${myconf} --enable-nad-debug"
	else
		if use memdebug; then
			ewarn
			ewarn '"memdebug" requires "debug" enabled.'
			ewarn
		fi
	fi

	econf \
		--sysconfdir=/etc/jabber \
		--enable-fs --enable-pipe --enable-anon \
		${myconf} \
		$(use_enable berkdb db) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_enable ssl) \
		$(use_with zlib)
	emake || die "make failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	fowners jabber:jabber /usr/bin/{jabberd,router,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,sm,c2s,s2s}

	newinitd "${FILESDIR}/${P}.init" jabberd || die "newinitd failed"
	newpamd "${FILESDIR}/${P}.pamd" jabberd || die "newpamd failed"

	dodoc AUTHORS README UPGRADE
	docinto tools
	dodoc tools/db-setup{.mysql,.pgsql,.sqlite}
	dodoc tools/{migrate.pl,pipe-auth.pl}

	cd "${D}/etc/jabber/"
	sed -i \
		-e 's,/var/lib/jabberd/pid/,/var/run/jabber/,g' \
		-e 's,/var/lib/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/lib/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml* || die "sed failed"
	sed -i \
		-e 's,<driver>mysql</driver>,<driver>db</driver>,' \
		sm.xml* || die "sed failed"

}

pkg_postinst() {

	if use pam; then
		echo
		ewarn 'Jabberd-2 PAM authentication requires your unix usernames to'
		ewarn 'be in the form of "contactname@jabberdomain". This behavior'
		ewarn 'is likely to change in future versions of jabberd-2. It may'
		ewarn 'be advisable to avoid PAM authentication for the time being.'
		echo
		ebeep
	fi

}
