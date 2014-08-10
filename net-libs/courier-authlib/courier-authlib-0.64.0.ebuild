# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/courier-authlib/courier-authlib-0.64.0.ebuild,v 1.8 2014/08/10 20:48:20 slyfox Exp $

inherit eutils flag-o-matic multilib user

KEYWORDS="alpha amd64 ~arm hppa ia64 ~ppc ~ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"

DESCRIPTION="Courier authentication library"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/"
LICENSE="GPL-3"
SLOT="0"
IUSE="berkdb crypt debug gdbm ldap mysql pam postgres vpopmail"

RESTRICT="userpriv
	!berkdb? ( test )"

RDEPEND="gdbm? ( sys-libs/gdbm )
		!gdbm? ( sys-libs/db )"

DEPEND="${RDEPEND}
		>=dev-libs/openssl-0.9.6
		ldap? ( >=net-nds/openldap-1.2.11 )
		mysql? ( virtual/mysql )
		pam? ( virtual/pam )
		postgres? ( >=dev-db/postgresql-base-8.4 )"

pkg_setup() {
	enewuser mail -1 -1 /var/spool/mail

	if ! has_version 'dev-tcltk/expect' ; then
		ewarn 'The dev-tcltk/expect package is not installed.'
		ewarn 'Without it, you will not be able to change system login passwords.'
		ewarn 'However non-system authentication modules (LDAP, MySQL, PostgreSQL,'
		ewarn 'and others) will work just fine.'
	fi

	if use vpopmail ; then
		eerror
		eerror "vpopmail support has been removed, it's unmaintained upstream and will be"
		eerror "removed with the next release."
		eerror
		eerror "Please remove vpopmail USE-flag."
		die "vpopmail support removed"
	fi

}

src_compile() {
	filter-flags -fomit-frame-pointer

	local myconf=""

	myconf="${myconf} `use_with pam authpam`"
	myconf="${myconf} `use_with ldap authldap`"

	if use berkdb ; then
		if use gdbm ; then
			ewarn "Both gdbm and berkdb selected. Using gdbm."
		else
			myconf="${myconf} --with-db=db"
		fi
	fi
	use gdbm && myconf="${myconf} --with-db=gdbm"

	myconf="${myconf} --without-authvchkpw `use_with mysql authmysql` `use_with postgres authpgsql`"

	use debug && myconf="${myconf} debug=true"

	einfo "Configuring courier-authlib: ${myconf}"

	econf \
		--sysconfdir=/etc/courier \
		--datadir=/usr/share/courier \
		--libexecdir=/usr/$(get_libdir)/courier \
		--localstatedir=/var/lib/courier \
		--sharedstatedir=/var/lib/courier/com \
		--with-authdaemonvar=/var/lib/courier/authdaemon \
		--with-authshadow \
		--without-redhat \
		--with-mailuser=mail \
		--with-mailgroup=mail \
		--cache-file="${S}/configuring.cache" \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

orderfirst() {
	file="${D}/etc/courier/authlib/${1}" ; option="${2}" ; param="${3}"
	if [[ -e "${file}" ]] ; then
		orig="$(grep \"^${option}=\" ${file} | cut -d'\"' -f 2)"
		new="${option}=\"${param} `echo ${orig} | sed -e\"s/${param}//g\" -e\"s/  / /g\"`\""
		sed -i -e "s/^${option}=.*$/${new}/" "${file}"
	fi
}

finduserdb() {
	for dir in \
		/etc/courier/authlib /etc/courier /etc/courier-imap \
		/usr/lib/courier/etc /usr/lib/courier-imap/etc \
		/usr/local/etc /usr/local/etc/courier /usr/local/courier/etc \
		/usr/local/lib/courier/etc /usr/local/lib/courier-imap/etc \
		/usr/local/share/sqwebmail /usr/local/etc/courier-imap ; do
		if [[ -e "${dir}/userdb" ]] ; then
			einfo "Found userdb at: ${dir}/userdb"
			cp -f "${dir}/userdb" "${D}/etc/courier/authlib/"
			chmod go-rwx "${D}/etc/courier/authlib/userdb"
			continue
		fi
	done
}

src_install() {
	diropts -o mail -g mail
	dodir /etc/courier
	keepdir /var/lib/courier/authdaemon
	keepdir /etc/courier/authlib
	emake DESTDIR="${D}" install || die "emake install failed"
	[[ ! -e "${D}/etc/courier/authlib/userdb" ]] && finduserdb
	emake DESTDIR="${D}" install-configure || die "emake install-configure failed"
	rm -f "${D}"/etc/courier/authlib/*.bak
	chown mail:mail "${D}"/etc/courier/authlib/*
	for y in "${D}"/etc/courier/authlib/*.dist ; do
		[[ ! -e "${y%%.dist}" ]] && cp -f "${y}" "${y%%.dist}"
	done
	use pam && orderfirst authdaemonrc authmodulelist authpam
	use ldap && orderfirst authdaemonrc authmodulelist authldap
	use postgres && orderfirst authdaemonrc authmodulelist authpgsql
	use mysql && orderfirst authdaemonrc authmodulelist authmysql
	dodoc AUTHORS ChangeLog* INSTALL NEWS README
	dohtml README.html README_authlib.html NEWS.html INSTALL.html README.authdebug.html
	if use mysql ; then
		dodoc README.authmysql.myownquery
		dohtml README.authmysql.html
	fi
	if use postgres ; then
		dohtml README.authpostgres.html README.authmysql.html
	fi
	if use ldap ; then
		dodoc README.ldap
		dodir /etc/openldap/schema
		cp -f authldap.schema "${D}/etc/openldap/schema/"
	fi
	newinitd "${FILESDIR}/${PN}-r1" "${PN}" || die "doinitd failed"
}

pkg_postinst() {
	if [[ -e /etc/courier/authlib/userdb ]] ; then
		einfo "Running makeuserdb ..."
		chmod go-rwx /etc/courier/authlib/userdb
		makeuserdb
	fi

	# Suggest cleaning out the following old files
	list="$(find /etc/courier -maxdepth 1 -type f | grep \"^/etc/courier/auth\")"
	if [[ ! -z "${list}" ]] ; then
		ewarn "Courier authentication files are now in /etc/courier/authlib/"
		elog "The following files are no longer needed and can likely be removed:"
		elog " rm $(echo \"${list}\")"
	fi
}
