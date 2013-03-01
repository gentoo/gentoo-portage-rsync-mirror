# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squid/squid-3.1.22.ebuild,v 1.11 2013/03/01 12:47:50 jlec Exp $

EAPI=4
inherit eutils pam toolchain-funcs autotools linux-info user

DESCRIPTION="A full-featured web proxy cache"
HOMEPAGE="http://www.squid-cache.org/"
SRC_URI="http://www.squid-cache.org/Versions/v3/3.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="caps ipv6 pam ldap samba sasl kerberos nis radius ssl snmp selinux logrotate test \
	ecap icap-client \
	mysql postgres sqlite \
	zero-penalty-hit \
	pf-transparent ipf-transparent kqueue \
	elibc_uclibc kernel_linux +epoll tproxy"

COMMON_DEPEND="caps? ( >=sys-libs/libcap-2.16 )
	pam? ( virtual/pam )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	ssl? ( dev-libs/openssl )
	sasl? ( dev-libs/cyrus-sasl )
	ecap? ( net-libs/libecap:0 )
	selinux? ( sec-policy/selinux-squid )
	!x86-fbsd? ( logrotate? ( app-admin/logrotate ) )
	>=sys-libs/db-4
	dev-lang/perl"
DEPEND="${COMMON_DEPEND}
	sys-apps/ed
	test? ( dev-util/cppunit )"
RDEPEND="${COMMON_DEPEND}
	samba? ( net-fs/samba )
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	sqlite? ( dev-perl/DBD-SQLite )
	!<=sci-biology/meme-4.8.1-r1"

REQUIRED_USE="tproxy? ( caps )"

pkg_pretend() {
	if grep -qs '^[[:space:]]*cache_dir[[:space:]]\+coss' "${ROOT}"etc/squid/squid.conf; then
		eerror "coss store IO has been disabled by upstream due to stability issues!"
		eerror "If you want to install this version, switch the store type to something else"
		eerror "before attempting to install this version again."

		die "/etc/squid/squid.conf: cache_dir uses a disabled store type"
	fi

	if use tproxy; then
		echo
		elog "Checking kernel configuration for full Tproxy4 support"
		local CONFIG_CHECK="~NF_CONNTRACK ~NETFILTER_TPROXY ~NETFILTER_XT_MATCH_SOCKET ~NETFILTER_XT_TARGET_TPROXY"
		linux-info_pkg_setup
		echo
	fi
}

pkg_setup() {
	enewgroup squid 31
	enewuser squid 31 -1 /var/cache/squid squid
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-3.1.15-gentoo.patch"
	eautoreconf
}

src_configure() {
	local myconf=""

	local basic_modules="getpwnam,NCSA,MSNT"
	use samba && basic_modules="SMB,multi-domain-NTLM,${basic_modules}"
	use ldap && basic_modules="LDAP,${basic_modules}"
	use pam && basic_modules="PAM,${basic_modules}"
	use sasl && basic_modules="SASL,${basic_modules}"
	use nis && ! use elibc_uclibc && basic_modules="YP,${basic_modules}"
	use radius && basic_modules="squid_radius_auth,${basic_modules}"
	if use mysql || use postgres || use sqlite ; then
		basic_modules="DB,${basic_modules}"
	fi

	local digest_modules="password"
	use ldap && digest_modules="ldap,${digest_modules}"

	local ext_helpers="ip_user,session,unix_group"
	use samba && ext_helpers="wbinfo_group,${ext_helpers}"
	use ldap && ext_helpers="ldap_group,${ext_helpers}"

	local ntlm_helpers="fakeauth"
	use samba && ntlm_helpers="smb_lm,${ntlm_helpers}"

	local negotiate_helpers=
	if use kerberos; then
		negotiate_helpers="squid_kerb_auth"
		if has_version app-crypt/mit-krb5; then
			myconf="--enable-mit=${EPREFIX}/usr --disable-heimdal"
		elif has_version app-crypt/heimdal; then
			myconf="--disable-mit --enable-heimdal=${EPREFIX}/usr"
		fi
	else
		myconf="--disable-mit --disable-heimdal"
	fi

	# coss support has been disabled
	# If it is re-enabled again, make sure you don't enable it for elibc_uclibc (#61175)
	myconf="${myconf} --enable-storeio=ufs,diskd,aufs"

	if use kernel_linux; then
		myconf="${myconf} --enable-linux-netfilter \
			$(use_enable tproxy linux-tproxy) \
			$(use_enable epoll)"
	elif use kernel_FreeBSD || use kernel_OpenBSD || use kernel_NetBSD ; then
		myconf="${myconf} $(use_enable kqueue)"
		if use pf-transparent; then
			myconf="${myconf} --enable-pf-transparent"
		elif use ipf-transparent; then
			myconf="${myconf} --enable-ipf-transparent"
		fi
	fi

	export CC=$(tc-getCC)

	econf \
		--sysconfdir=/etc/squid \
		--libexecdir=/usr/libexec/squid \
		--localstatedir=/var \
		--with-pidfile=/var/run/squid.pid \
		--datadir=/usr/share/squid \
		--with-logdir=/var/log/squid \
		--with-default-user=squid \
		--enable-auth="basic,digest,negotiate,ntlm" \
		--enable-removal-policies="lru,heap" \
		--enable-digest-auth-helpers="${digest_modules}" \
		--enable-basic-auth-helpers="${basic_modules}" \
		--enable-external-acl-helpers="${ext_helpers}" \
		--enable-ntlm-auth-helpers="${ntlm_helpers}" \
		--enable-negotiate-auth-helpers="${negotiate_helpers}" \
		--enable-useragent-log \
		--enable-cache-digests \
		--enable-delay-pools \
		--enable-referer-log \
		--enable-arp-acl \
		--with-large-files \
		--with-filedescriptors=8192 \
		--disable-strict-error-checking \
		$(use_with caps libcap) \
		$(use_enable ipv6) \
		$(use_enable snmp) \
		$(use_enable ssl) \
		$(use_enable icap-client) \
		$(use_enable ecap) \
		$(use_enable zero-penalty-hit zph-qos) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	# need suid root for looking into /etc/shadow
	fowners root:squid /usr/libexec/squid/ncsa_auth
	fperms 4750 /usr/libexec/squid/ncsa_auth
	if use pam; then
		fowners root:squid /usr/libexec/squid/pam_auth
		fperms 4750 /usr/libexec/squid/pam_auth
	fi

	# some cleanups
	rm -f "${D}"/usr/bin/Run*

	dodoc CONTRIBUTORS CREDITS ChangeLog QUICKSTART SPONSORS doc/*.txt \
		helpers/ntlm_auth/no_check/README.no_check_ntlm_auth
	newdoc helpers/basic_auth/SMB/README README.auth_smb
	dohtml helpers/basic_auth/MSNT/README.html RELEASENOTES.html
	newdoc helpers/basic_auth/LDAP/README README.auth_ldap
	doman helpers/basic_auth/LDAP/*.8
	dodoc helpers/basic_auth/SASL/squid_sasl_auth*

	newpamd "${FILESDIR}/squid.pam" squid
	newconfd "${FILESDIR}/squid.confd" squid
	if use logrotate; then
		newinitd "${FILESDIR}/squid.initd-logrotate-r1" squid
		insinto /etc/logrotate.d
		newins "${FILESDIR}/squid.logrotate" squid
	else
		newinitd "${FILESDIR}/squid.initd-r1" squid
		exeinto /etc/cron.weekly
		newexe "${FILESDIR}/squid.cron" squid.cron
	fi

	rm -rf "${D}"/var
	diropts -m0755 -o squid -g squid
	keepdir /var/cache/squid /var/log/squid
}

pkg_postinst() {
	echo
	elog "Squid authentication helpers have been installed suid root."
	elog "This allows shadow based authentication (see bug #52977 for more)."
	echo
	elog "Be careful what type of cache_dir you select!"
	elog "   'diskd' is optimized for high levels of traffic, but it might seem slow"
	elog "when there isn't sufficient traffic to keep squid reasonably busy."
	elog "   If your traffic level is low to moderate, use 'aufs' or 'ufs'."
}
