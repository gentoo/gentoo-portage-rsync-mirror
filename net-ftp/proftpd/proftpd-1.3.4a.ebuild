# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.3.4a.ebuild,v 1.3 2012/05/13 10:49:47 swift Exp $

EAPI=4
inherit eutils autotools

MOD_CASE="0.7"
MOD_CLAMAV="0.11rc"
MOD_DISKUSE="0.9"
MOD_GSS="1.3.3"
MOD_VROOT="0.9.2"

DESCRIPTION="An advanced and very configurable FTP server."
HOMEPAGE="http://www.proftpd.org/
	http://www.castaglia.org/proftpd/
	http://www.thrallingpenguin.com/resources/mod_clamav.htm
	http://gssmod.sourceforge.net/"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P/_/}.tar.bz2
	case? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-case-${MOD_CASE}.tar.gz )
	clamav? ( https://secure.thrallingpenguin.com/redmine/attachments/download/1/mod_clamav-${MOD_CLAMAV}.tar.gz )
	diskuse? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-diskuse-${MOD_DISKUSE}.tar.gz )
	kerberos? ( mirror://sourceforge/gssmod/mod_gss-${MOD_GSS}.tar.gz )
	vroot? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-vroot-${MOD_VROOT}.tar.gz )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="acl authfile ban +caps case clamav copy ctrls deflate diskuse doc exec ifsession ifversion ident
	ipv6 kerberos ldap memcache mysql ncurses nls pam +pcre postgres qos radius ratio readme rewrite
	selinux sftp shaper sitemisc softquota sqlite ssl tcpd test trace vroot xinetd"

CDEPEND="acl? ( virtual/acl )
	caps? ( sys-libs/libcap )
	clamav? ( app-antivirus/clamav )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	memcache? ( >=dev-libs/libmemcached-0.41 )
	mysql? ( virtual/mysql )
	nls? ( virtual/libiconv )
	ncurses? ( sys-libs/ncurses )
	pam? ( virtual/pam )
	pcre? ( dev-libs/libpcre )
	postgres? ( dev-db/postgresql-base )
	sftp? ( dev-libs/openssl )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl )
	xinetd? ( virtual/inetd )"
DEPEND="${CDEPEND}
	test? ( dev-libs/check )"
RDEPEND="${CDEPEND}
	net-ftp/ftpbase
	selinux? ( sec-policy/selinux-ftp )"

S="${WORKDIR}/${P/_/}"

__prepare_module() {
	mv "${WORKDIR}"/$1/$1.c contrib
	mv "${WORKDIR}"/$1/$1.html doc/contrib
	rm -rf "${WORKDIR}"/$1
}

src_prepare() {
	use case && __prepare_module mod_case
	if use clamav ; then
		mv "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}/mod_clamav.{c,h} contrib
		epatch "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}/${PN}.patch
		rm -rf "${WORKDIR}"/mod_clamav-${MOD_CLAMAV}
	fi
	use vroot && __prepare_module mod_vroot

	sed -i -e "s/utils install-conf install/utils install/g" Makefile.in

	# Fixes Gentoo Bug #354295 / ProFTPD Bug #3682
	epatch "${FILESDIR}"/${P}-ubug-3682.patch

	# Fixes Gentoo Bug #393189 / ProFTPD Bug #3728
	epatch "${FILESDIR}"/${P}-ubug-3728.patch

	# Support new versions of mit-krb5 (Gentoo Bugs #284853, #324903)
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${MOD_GSS}
		sed -i -e "s/krb5_principal2principalname/_\0/" mod_auth_gss.c.in
		sed -i -e "/ac_gss_libs/s/\-ldes425\ //" configure.in
		eautoreconf
	fi
}

src_configure() {
	local c m

	use acl && m="${m}:mod_facl"
	use ban && m="${m}:mod_ban"
	use case && m="${m}:mod_case"
	use clamav && m="${m}:mod_clamav"
	use copy && m="${m}:mod_copy"
	if use ctrls || use ban || use shaper ; then
		c="${c} --enable-ctrls"
		m="${m}:mod_ctrls_admin"
	fi
	use deflate && m="${m}:mod_deflate"
	if use diskuse ; then
		cd "${WORKDIR}"/mod_diskuse
		econf
		mv mod_diskuse.{c,h} "${S}"/contrib
		mv mod_diskuse.html "${S}"/doc/contrib
		cd "${S}"
		rm -rf "${WORKDIR}"/mod_diskuse
		m="${m}:mod_diskuse"
	fi
	use exec && m="${m}:mod_exec"
	use ifsession && m="${m}:mod_ifsession"
	use ifversion && m="${m}:mod_ifversion"
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${MOD_GSS}
		if has_version app-crypt/mit-krb5 ; then
			econf --enable-mit
		else
			econf --enable-heimdal
		fi
		mv mod_{auth_gss,gss}.c "${S}"/contrib
		mv mod_gss.h "${S}"/include
		mv README.mod_{auth_gss,gss} "${S}"
		mv mod_gss.html "${S}"/doc/contrib
		mv rfc{1509,2228}.txt "${S}"/doc/rfc
		cd "${S}"
		rm -rf "${WORKDIR}"/mod_gss-${MOD_GSS}
		m="${m}:mod_gss:mod_auth_gss"
	fi
	use ldap && m="${m}:mod_ldap"
	if use mysql || use postgres || use sqlite ; then
		m="${m}:mod_sql:mod_sql_passwd"
		use mysql && m="${m}:mod_sql_mysql"
		use postgres && m="${m}:mod_sql_postgres"
		use sqlite && m="${m}:mod_sql_sqlite"
	fi
	use qos && m="${m}:mod_qos"
	use radius && m="${m}:mod_radius"
	use ratio && m="${m}:mod_ratio"
	use readme && m="${m}:mod_readme"
	use rewrite && m="${m}:mod_rewrite"
	use sftp || use ssl && c="${c} --enable-openssl"
	if use sftp ; then
		m="${m}:mod_sftp"
		use pam && m="${m}:mod_sftp_pam"
		use mysql || use postgres || use sqlite && m="${m}:mod_sftp_sql"
	fi
	use shaper && m="${m}:mod_shaper"
	use sitemisc && m="${m}:mod_site_misc"
	if use softquota ; then
		m="${m}:mod_quotatab:mod_quotatab_file"
		use ldap && m="${m}:mod_quotatab_ldap"
		use radius && m="${m}:mod_quotatab_radius"
		use mysql || use postgres || use sqlite && m="${m}:mod_quotatab_sql"
	fi
	if use ssl ; then
		m="${m}:mod_tls:mod_tls_shmcache"
		use memcache && m="${m}:mod_tls_memcache"
	fi
	if use tcpd ; then
		m="${m}:mod_wrap2:mod_wrap2_file"
		use mysql || use postgres || use sqlite && m="${m}:mod_wrap2_sql"
	fi
	use vroot && m="${m}:mod_vroot"

	[ -z ${m} ] || c="${c} --with-modules=${m:1}"
	econf --localstatedir=/var/run/proftpd --sysconfdir=/etc/proftpd --disable-strip \
		$(use_enable acl facl) \
		$(use_enable authfile auth-file) \
		$(use_enable caps cap) \
		$(use_enable ident) \
		$(use_enable ipv6) \
		$(use_enable memcache) \
		$(use_enable ncurses) \
		$(use_enable nls) \
		$(use_enable pam auth-pam) \
		$(use_enable pcre) \
		$(use_enable test tests) \
		$(use_enable trace) \
		$(use_enable userland_GNU shadow) \
		$(use_enable userland_GNU autoshadow) \
		${c:1}
}

src_test() {
	emake api-tests -C tests
}

src_install() {
	default
	newinitd "${FILESDIR}"/proftpd.initd proftpd
	insinto /etc/proftpd
	doins "${FILESDIR}"/proftpd.conf.sample

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}"/proftpd.xinetd proftpd
	fi

	dodoc ChangeLog CREDITS INSTALL NEWS README* RELEASE_NOTES
	if use doc ; then
		dohtml doc/*.html doc/contrib/*.html doc/howto/*.html doc/modules/*.html
		docinto rfc
		dodoc doc/rfc/*.txt
	fi
}

pkg_postinst() {
	if use tcpd ; then
		ewarn
		ewarn "Important: Since ProFTPD 1.3.4rc2 the module mod_wrap for TCP Wrapper"
		ewarn "support has been replaced by mod_wrap2 which is more configurable and"
		ewarn "portable.  But you have to adjust your configuration before restaring"
		ewarn "ProFTPD. On the following website you can find more information:"
		ewarn "  http://proftpd.org/docs/contrib/mod_wrap2.html"
		ewarn
	fi
}
