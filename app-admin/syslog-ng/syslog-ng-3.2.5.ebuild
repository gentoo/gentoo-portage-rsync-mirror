# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-3.2.5.ebuild,v 1.8 2012/05/03 18:02:22 jdhore Exp $

EAPI=2
inherit autotools fixheadtails eutils multilib

MY_PV=${PV/_/}
DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/files/syslog-ng/sources/${PV}/source/syslog-ng_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="caps hardened ipv6 +pcre selinux spoof-source sql ssl tcpd"
RESTRICT="test"

RDEPEND="
		pcre? ( dev-libs/libpcre )
		spoof-source? ( net-libs/libnet )
		ssl? ( dev-libs/openssl )
		tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
		>=dev-libs/eventlog-0.2.12
		>=dev-libs/glib-2.10.1:2
		caps? ( sys-libs/libcap )
		sql? ( >=dev-db/libdbi-0.8.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex"

src_prepare() {
	ht_fix_file configure.in
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--enable-dynamic-linking \
		--sysconfdir=/etc/syslog-ng \
		--localstatedir=/var/lib/misc \
		--with-pidfile-dir=/var/run \
		--with-module-dir=/usr/$(get_libdir)/syslog-ng \
		$(use_enable caps linux-caps) \
		$(use_enable ipv6) \
		$(use_enable pcre) \
		$(use_enable spoof-source) \
		$(use_enable sql) \
		$(use_enable ssl) \
		$(use_enable tcpd tcp-wrapper)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README \
		contrib/syslog-ng.conf* \
		contrib/syslog2ng "${FILESDIR}/syslog-ng.conf."*

	# Install default configuration
	insinto /etc/syslog-ng
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.hardened.${PV%.*}" syslog-ng.conf || die
	elif use userland_BSD ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.fbsd.${PV%.*}" syslog-ng.conf || die
	else
		newins "${FILESDIR}/syslog-ng.conf.gentoo.${PV%.*}" syslog-ng.conf || die
	fi

	insinto /etc/logrotate.d
	# Install snippet for logrotate, which may or may not be installed
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.logrotate.hardened" syslog-ng || die
	else
		newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng || die
	fi

	newinitd "${FILESDIR}/syslog-ng.rc6.${PV%%.*}" syslog-ng || die
	newconfd "${FILESDIR}/syslog-ng.confd" syslog-ng || die
	keepdir /etc/syslog-ng/patterndb.d
	find "${D}" -type f -name '*.la' -exec rm {} + || die
}

pkg_postinst() {
	# bug #355257
	if ! has_version app-admin/logrotate ; then
		echo
		elog "It is highly recommended that app-admin/logrotate be emerged to"
		elog "manage the log files.  ${PN} installs a file in /etc/logrotate.d"
		elog "for logrotate to use."
		echo
	fi
}
