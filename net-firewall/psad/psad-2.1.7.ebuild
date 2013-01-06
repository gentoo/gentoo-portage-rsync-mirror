# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/psad/psad-2.1.7.ebuild,v 1.5 2010/12/21 13:52:48 klausman Exp $

inherit eutils perl-app

IUSE=""

DESCRIPTION="Port Scanning Attack Detection daemon"
SRC_URI="http://www.cipherdyne.org/psad/download/${P}.tar.bz2"
HOMEPAGE="http://www.cipherdyne.org/psad"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ~sparc x86"

DEPEND="${DEPEND}
	dev-lang/perl"

RDEPEND="virtual/logger
	dev-perl/Unix-Syslog
	dev-perl/Date-Calc
	virtual/mailx
	net-firewall/iptables
	net-misc/whois"

src_compile() {
	cd "${S}"/deps/Net-IPv4Addr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"/deps/IPTables-Parse
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"/deps/IPTables-ChainMgr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"
	# We'll use the C binaries
	emake || die "Make failed: daemons"
}

src_install() {
	local myhostname=
	local mydomain=

	doman *.8

	keepdir /var/lib/psad /var/log/psad /var/run/psad /var/lock/subsys/${PN}
	dodir /etc/psad

	cd "${S}"/deps/Net-IPv4Addr
	perl-module_src_install

	cd "${S}"/deps/IPTables-ChainMgr
	perl-module_src_install

	cd "${S}"/deps/IPTables-Parse
	perl-module_src_install

	cd "${S}"
	insinto /usr
	dosbin kmsgsd psad psadwatchd
	newsbin fwcheck_psad.pl fwcheck_psad
	newbin pscan psad-pscan

	cd "${S}"

	insinto /etc/psad
	doins *.conf
	doins psad_*
	doins auto_dl icmp_types ip_options posf signatures pf.os

	cd "${S}"/init-scripts
	newinitd psad-init.gentoo psad

	cd "${S}"/deps/snort_rules
	dodir /etc/psad/snort_rules
	insinto /etc/psad/snort_rules
	doins *.rules

	cd "${S}"
	dodoc BENCHMARK CREDITS Change* FW_EXAMPLE_RULES README SCAN_LOG
}

pkg_preinst() {
	cd "${S}"

	# Set sane defaults in config file.
	fix_psad_conf
}

pkg_postinst() {
	if [ ! -p "${ROOT}"/var/lib/psad/psadfifo ]
	then
		ebegin "Creating syslog FIFO for PSAD"
		mknod -m 600 "${ROOT}"/var/lib/psad/psadfifo p
		eend $?
	fi

	echo
	elog "Please be sure to edit /etc/psad/psad.conf to reflect your system's"
	elog "configuration or it may not work correctly or start up. Specifically, check"
	elog "the validity of the HOSTNAME setting and replace the EMAIL_ADDRESSES and"
	elog "HOME_NET settings at the least."
	elog
	if has_version ">=app-admin/syslog-ng-0.0.0"
	then
		ewarn "You appear to have installed syslog-ng. If you are using syslog-ng as your"
		ewarn "default system logger, please change the SYSLOG_DAEMON entry in"
		ewarn "/etc/psad/psad.conf to the following (per examples in psad.conf):"
		ewarn "		SYSLOG_DAEMON	syslog-ng;"
		ewarn
	fi
	if has_version ">=app-admin/sysklogd-0.0.0"
	then
		elog "You have sysklogd installed. If this is your default system logger, no"
		elog "special configuration is needed. If it is not, please set SYSLOG_DAEMON"
		elog "in /etc/psad/psad.conf accordingly."
		elog
	fi
	if has_version ">=app-admin/metalog-0.0"
	then
		ewarn "You appear to have installed metalog. If you are using metalog as your"
		ewarn "default system logger, please change the SYSLOG_DAEMON entry in"
		ewarn "/etc/psad/psad.conf to the following (per examples in psad.conf):"
		ewarn "		SYSLOG_DAEMON	metalog"
	fi

	ewarn "NOTE: You need firewall rules to log dropped packets. Otherwise PSAD will"
	ewarn "not be aware of any port scan attacks. Please see FW_EXAMPLE_RULES in the"
	ewarn "psad documentation directory (ie /usr/share/doc/${P}) for the criteria and"
	ewarn "sample rules."
}

fix_psad_conf() {
	cp psad.conf psad.conf.orig

	# Ditch the _CHANGEME_ for hostname, substituting in our real hostname
	[ -e /etc/hostname ] && myhostname="$(< /etc/hostname)"
	[ "${myhostname}" == "" ] && myhostname="$HOSTNAME"
	mydomain=".$(grep ^domain /etc/resolv.conf | cut -d" " -f2)"
	sed -i "s:HOSTNAME\(.\+\)\_CHANGEME\_;:HOSTNAME\1${myhostname}${mydomain};:" psad.conf || die "fix_psad_conf failed"

	# Fix up paths
	sed -i "s:/sbin/syslogd:/usr/sbin/syslogd:g" psad.conf || die "fix_psad_conf failed"
	sed -i "s:/sbin/syslog-ng:/usr/sbin/syslog-ng:g" psad.conf || die "fix_psad_conf failed"
	sed -i "s:/usr/bin/whois_psad:/usr/bin/whois:g" psad.conf || die "fix_psad_conf failed"
}
