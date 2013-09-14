# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd2/jabberd2-2.2.14-r1.ebuild,v 1.4 2013/09/14 10:13:51 ago Exp $

EAPI=5

inherit db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.org"
SRC_URI="http://ftp.xiaoka.com/${PN}/releases/jabberd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"

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
	>=net-im/jabber-base-0.01"

S="${WORKDIR}/jabberd-${PV}"

REQUIRED_USE="memdebug? ( debug )"

DOCS=( AUTHORS README UPGRADE )

src_configure() {
	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	use berkdb && myconf="${myconf} --with-extra-include-path=$(db_includedir)"

	# --enable-pool-debug is currently broken
	econf \
		--sysconfdir=/etc/jabber \
		--enable-fs --enable-pipe --enable-anon \
		${myconf} \
		$(use debug && echo '--enable-debug') \
		$(use memdebug && echo '--enable-nad-debug') \
		$(use_enable berkdb db) \
		$(use_enable ldap) \
		$(use_enable mysql) \
		$(use_enable pam) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_enable ssl) \
		$(use_with zlib)
}

src_install() {
	default
	prune_libtool_files --modules

	fowners jabber:jabber /usr/bin/{jabberd,router,sm,c2s,s2s}
	fperms 750 /usr/bin/{jabberd,router,sm,c2s,s2s}

	newinitd "${FILESDIR}/${PN}-2.2.8.init" jabberd
	newpamd "${FILESDIR}/${PN}-2.2.8.pamd" jabberd

	docinto tools
	dodoc tools/db-setup{.mysql,.pgsql,.sqlite}
	dodoc tools/{migrate-jd14dir-2-sqlite.pl,pipe-auth.pl}

	pushd "${D}/etc/jabber/" &>/dev/null || die
	sed -i \
		-e 's,/var/lib/jabberd/pid/,/run/jabber/,g' \
		-e 's,/var/lib/jabberd/log/,/var/log/jabber/,g' \
		-e 's,/var/lib/jabberd/db,/var/spool/jabber/,g' \
		*.xml *.xml.dist || die "sed failed"
	sed -i \
		-e 's,<module>mysql</module>,<module>db</module>,' \
		c2s.xml* || die "sed failed"
	sed -i \
		-e 's,<driver>mysql</driver>,<driver>db</driver>,' \
		sm.xml* || die "sed failed"
	popd
}

pkg_postinst() {

	if use pam; then
		echo
		ewarn 'Jabberd-2 PAM authentication requires your unix usernames to'
		ewarn 'be in the form of "contactname@jabberdomain". This behavior'
		ewarn 'is likely to change in future versions of jabberd-2. It may'
		ewarn 'be advisable to avoid PAM authentication for the time being.'
		echo
	fi

}
