# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd2/jabberd2-2.2.17.ebuild,v 1.4 2013/11/01 22:11:47 hasufell Exp $

EAPI=5

inherit db-use eutils flag-o-matic pam

DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://jabberd2.org"
SRC_URI="mirror://github/jabberd2/jabberd2/jabberd-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="berkdb debug ldap memdebug mysql pam postgres sqlite ssl test zlib"
REQUIRED_USE="memdebug? ( debug )"

# broken
RESTRICT="test"

DEPEND="dev-libs/expat
	net-libs/udns
	net-dns/libidn
	virtual/gsasl
	berkdb? ( >=sys-libs/db-4.1.25 )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql-base )
	ssl? ( >=dev-libs/openssl-1.0.1:0 )
	sqlite? ( dev-db/sqlite:3 )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	>=net-im/jabber-base-0.01"
DEPEND="${DEPEND}
	app-arch/xz-utils
	virtual/pkgconfig
	test? ( dev-libs/check )"

DOCS=( AUTHORS README UPGRADE )

S=${WORKDIR}/jabberd-${PV}

src_prepare() {
	# Fix some default directory locations
	sed -i \
		-e 's,@localstatedir@/@package@/pid/,/var/run/@package@/,g' \
		-e 's,@localstatedir@/@package@/run/pbx,/var/run/@package@/pbx,g' \
		-e 's,@localstatedir@/@package@/log/,/var/log/@package@/,g' \
		-e 's,@localstatedir@/lib/jabberd2/fs,@localstatedir@/@package@/fs,g' \
		-e 's,@localstatedir@,/var/spool,g' \
		-e 's,@package@,jabber,g' \
		etc/{sm,router,c2s,s2s}.xml.dist.in || die

	# If the package wasn't merged with sqlite then default to use berkdb
	use sqlite ||
		sed -i \
			-e 's,<\(module\|driver\)>sqlite<\/\1>,<\1>db</\1>,g' \
			etc/{c2s,sm}.xml.dist.in || die
}

src_configure() {
	# https://bugs.gentoo.org/show_bug.cgi?id=207655#c3
	replace-flags -O[3s] -O2

	# --enable-pool-debug is currently broken
	econf \
		--sysconfdir=/etc/jabber \
		$(usex debug "--enable-debug" "") \
		$(usex memdebug "--enable-nad-debug" "") \
		$(use_enable ssl) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite) \
		$(use_enable berkdb db) \
		$(use_enable ldap) \
		$(use_enable pam) \
		--enable-pipe \
		--enable-anon \
		--enable-fs \
		$(use_enable test tests) \
		$(usex berkdb "--with-extra-include-path=$(db_includedir)" "") \
		$(use_with zlib)
}

src_install() {
	default
	prune_libtool_files --modules

	keepdir /var/spool/jabber/{fs,db}
	fowners jabber:jabber /usr/bin/{jabberd,router,sm,c2s,s2s} \
		/var/spool/jabber/{fs,db}
	fperms 770 /var/spool/jabber/{fs,db}
	fperms 750 /usr/bin/{jabberd,router,sm,c2s,s2s}

	newinitd "${FILESDIR}/${PN}-2.2.17.init" jabberd
	newpamd "${FILESDIR}/${PN}-2.2.8.pamd" jabberd
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}-2.2.17.logrotate" jabberd

	docompress -x /usr/share/doc/${PF}/tools
	docinto tools
	dodoc tools/db-setup{.mysql,.pgsql,.sqlite} \
		tools/{migrate-jd14dir-2-sqlite.pl,pipe-auth.pl}
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

	if use sqlite || use mysql || use postgres; then
		echo
		einfo 'You will need to setup or update your database using the'
		einfo "scripts in /usr/share/doc/${PF}/tools/"
		echo
	fi

}
