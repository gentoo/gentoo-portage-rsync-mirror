# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.3.3g.ebuild,v 1.7 2012/05/13 10:49:47 swift Exp $

EAPI="2"
inherit eutils autotools

CASE_VER="0.4"
CLAMAV_VER="0.11rc"
DEFLATE_VER="0.5.4"
GSS_VER="1.3.3"
VROOT_VER="0.9.2"

DESCRIPTION="An advanced and very configurable FTP server."
HOMEPAGE="http://www.proftpd.org/
	http://www.castaglia.org/proftpd/
	http://www.thrallingpenguin.com/resources/mod_clamav.htm
	http://gssmod.sourceforge.net/"
SRC_URI="ftp://ftp.proftpd.org/distrib/source/${P/_/}.tar.bz2
	case? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-case-${CASE_VER}.tar.gz )
	clamav? ( https://secure.thrallingpenguin.com/redmine/attachments/download/1/mod_clamav-${CLAMAV_VER}.tar.gz )
	deflate? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-deflate-${DEFLATE_VER}.tar.gz )
	kerberos? ( mirror://sourceforge/gssmod/mod_gss-${GSS_VER}.tar.gz )
	vroot? ( http://www.castaglia.org/${PN}/modules/${PN}-mod-vroot-${VROOT_VER}.tar.gz )"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="acl authfile ban +caps case clamav +ctrls deflate doc exec ifsession ident ipv6 kerberos ldap mysql ncurses nls pam postgres radius ratio readme rewrite selinux sftp shaper sitemisc softquota ssl tcpd trace vroot xinetd"

DEPEND="acl? ( sys-apps/acl sys-apps/attr )
	caps? ( sys-libs/libcap )
	clamav? ( app-antivirus/clamav )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	ncurses? ( sys-libs/ncurses )
	pam? ( virtual/pam )
	postgres? ( dev-db/postgresql-base )
	sftp? ( dev-libs/openssl )
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )
	xinetd? ( virtual/inetd )"
RDEPEND="${DEPEND}
	net-ftp/ftpbase
	selinux? ( sec-policy/selinux-ftp )"

S="${WORKDIR}/${P/_/}"

__prepare_module() {
	mv "${WORKDIR}"/$1/$1.c contrib
	mv "${WORKDIR}"/$1/$1.html doc/contrib
	rm -rf "${WORKDIR}"/$1
}

pkg_setup() {
	if [ -f "${ROOT}"/var/run/proftpd.pid ] ; then
		eerror "Your ProFTPD server is running. In order to install this update"
		eerror "you have to stop the running server. If you are using ProFTPD in"
		eerror "the standalone mode you can stop the server by executing:"
		eerror "  /etc/init.d/proftpd stop"
		eerror "If you are sure that ProFTPD is not running anymore you have to"
		eerror "delete the /var/run/proftpd.pid file."
		die "This update requires to stop the ProFTPD server!"
	fi
}

src_prepare() {
	use case && __prepare_module mod_case
	if use clamav ; then
		mv "${WORKDIR}"/mod_clamav-${CLAMAV_VER}/mod_clamav.{c,h} contrib
		epatch "${WORKDIR}"/mod_clamav-${CLAMAV_VER}/${PN}.patch
		rm -rf "${WORKDIR}"/mod_clamav-${CLAMAV_VER}
	fi
	use deflate && __prepare_module mod_deflate
	use vroot && __prepare_module mod_vroot

	# Fix MySQL includes
	sed -i -e "s/<mysql.h>/<mysql\/mysql.h>/g" contrib/mod_sql_mysql.c

	# Manipulate build system
	sed -i -e "s/utils install-conf install/utils install/g" Makefile.in
	sed -i -e "s/ @INSTALL_STRIP@//g" Make.rules.in

	# Support new versions of mit-krb5 (Gentoo Bugs #284853, #324903)
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${GSS_VER}
		sed -i -e "s/krb5_principal2principalname/_\0/" mod_auth_gss.c.in
		sed -i -e "/ac_gss_libs/s/\-ldes425\ //" configure.in
		eautoreconf
	fi
}

src_configure() {
	local myc myl mym

	use acl && mym="${mym}:mod_facl"
	use ban && mym="${mym}:mod_ban"
	use case && mym="${mym}:mod_case"
	use clamav && mym="${mym}:mod_clamav"
	if use ctrls || use ban || use shaper ; then
		myc="${myc} --enable-ctrls"
		mym="${mym}:mod_ctrls_admin"
	fi
	use deflate && mym="${mym}:mod_deflate"
	use exec && mym="${mym}:mod_exec"
	if use kerberos ; then
		cd "${WORKDIR}"/mod_gss-${GSS_VER}
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
		rm -rf "${WORKDIR}"/mod_gss-${GSS_VER}
		mym="${mym}:mod_gss:mod_auth_gss"
	fi
	if use ldap ; then
		myl="${myl} -lresolv"
		mym="${mym}:mod_ldap"
	fi
	if use mysql || use postgres ; then
		mym="${mym}:mod_sql:mod_sql_passwd"
		if use mysql ; then
			myc="${myc} --with-includes=/usr/include/mysql"
			mym="${mym}:mod_sql_mysql"
		fi
		if use postgres ; then
			myc="${myc} --with-includes=/usr/include/postgresql"
			mym="${mym}:mod_sql_postgres"
		fi
	fi
	if use sftp || use ssl ; then
		CFLAGS="${CFLAGS} -DHAVE_OPENSSL"
		myc="${myc} --enable-openssl --with-includes=/usr/include/openssl"
		myl="${myl} -lcrypto"
	fi
	use radius && mym="${mym}:mod_radius"
	use ratio && mym="${mym}:mod_ratio"
	use readme && mym="${mym}:mod_readme"
	use rewrite && mym="${mym}:mod_rewrite"
	if use sftp ; then
		mym="${mym}:mod_sftp"
		use pam && mym="${mym}:mod_sftp_pam"
		if use mysql || use postgres ; then
			mym="${mym}:mod_sftp_sql"
		fi
	fi
	use shaper && mym="${mym}:mod_shaper"
	use sitemisc && mym="${mym}:mod_site_misc"
	if use softquota ; then
		mym="${mym}:mod_quotatab:mod_quotatab_file"
		use ldap && mym="${mym}:mod_quotatab_ldap"
		use radius && mym="${mym}:mod_quotatab_radius"
		if use mysql || use postgres ; then
			mym="${mym}:mod_quotatab_sql"
		fi
	fi
	use ssl && mym="${mym}:mod_tls:mod_tls_shmcache"
	use tcpd && mym="${mym}:mod_wrap"
	use vroot && mym="${mym}:mod_vroot"
	# mod_ifsession needs to be the last module in the mym list.
	use ifsession && mym="${mym}:mod_ifsession"

	[ -z ${mym} ] || myc="${myc} --with-modules=${mym:1}"
	LIBS="${myl:1}" econf --sbindir=/usr/sbin --localstatedir=/var/run/proftpd \
		--sysconfdir=/etc/proftpd --enable-shadow --enable-autoshadow ${myc:1} \
		$(use_enable acl facl) \
		$(use_enable authfile auth-file) \
		$(use_enable caps cap) \
		$(use_enable ident) \
		$(use_enable ipv6) \
		$(use_enable ncurses) \
		$(use_enable nls) \
		$(use_enable trace) \
		$(use_enable pam auth-pam)
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	insinto /etc/proftpd
	doins "${FILESDIR}"/proftpd.conf.sample
	newinitd "${FILESDIR}"/proftpd.initd proftpd
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
	if use mysql && use postgres ; then
		elog
		elog "ProFTPD has been built with the MySQL and PostgreSQL modules."
		elog "You can use the 'SQLBackend' directive to specify the used SQL"
		elog "backend. Without this directive the default backend is MySQL."
		elog
	fi
	if use exec ; then
		ewarn
		ewarn "ProFTPD has been built with the mod_exec module. This module"
		ewarn "can be a security risk for your server as it executes external"
		ewarn "programs. Vulnerables in these external programs may disclose"
		ewarn "information or even compromise your server."
		ewarn "You have been warned! Use this module at your own risk!"
		ewarn
	fi
}
