# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.9.1.ebuild,v 1.10 2014/12/05 10:15:37 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1 systemd vcs-snapshot

DESCRIPTION="scans log files and bans IPs that show malicious signs"
HOMEPAGE="http://www.fail2ban.org/"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="selinux systemd"

DEPEND=""
RDEPEND="
	net-misc/whois
	virtual/mta
	virtual/logger
	net-firewall/iptables
	selinux? ( sec-policy/selinux-fail2ban )
	systemd? ( sys-apps/systemd[python] )
"

DOCS=( ChangeLog DEVELOP README.md THANKS TODO doc/run-rootless.txt )

src_prepare() {
	# Replace /var/run with /run, but not in the top source directory
	sed -i -e 's|/var\(/run/fail2ban\)|\1|g' $( find . -type f -mindepth 2 ) || die

	distutils-r1_src_prepare
}

python_test() {
	${EPYTHON} bin/${PN}-testcases
}

src_install() {
	distutils-r1_src_install

	rm -rf "${D}"/usr/share/doc/${PN}

	# not FILESDIR
	newconfd files/gentoo-confd ${PN}
	newinitd files/gentoo-initd ${PN}
	systemd_dounit files/${PN}.service
	systemd_dotmpfilesd files/${PN}-tmpfiles.conf
	doman man/*.{1,5}

	# Use INSTALL_MASK  if you do not want to touch /etc/logrotate.d.
	# See http://thread.gmane.org/gmane.linux.gentoo.devel/35675
	insinto /etc/logrotate.d
	newins files/${PN}-logrotate ${PN}
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.7"
	previous_less_than_0_7=$?
}

pkg_postinst() {
	if [[ $previous_less_than_0_7 = 0 ]] ; then
		elog
		elog "Configuration files are now in /etc/fail2ban/"
		elog "You probably have to manually update your configuration"
		elog "files before restarting Fail2ban!"
		elog
		elog "Fail2ban is not installed under /usr/lib anymore. The"
		elog "new location is under /usr/share."
		elog
		elog "You are upgrading from version 0.6.x, please see:"
		elog "http://www.fail2ban.org/wiki/index.php/HOWTO_Upgrade_from_0.6_to_0.8"
	fi
	if ! has_version ${CATEGORY}/${PN}; then
		if ! has_version dev-python/pyinotify && ! has_version app-admin/gamin; then
			elog "For most jail.conf configurations, it is recommended you install either"
			elog "dev-python/pyinotify or app-admin/gamin (in order of preference)"
			elog "to control how log file modifications are detected"
		fi
		if ! has_version dev-lang/python[sqlite]; then
			elog "If you want to use ${PN}'s persistent database, then reinstall"
			elog "dev-lang/python with USE=sqlite"
		fi

		if has_version sys-apps/systemd[-python]; then
			elog "If you want to track logins through sys-apps/systemd's"
			elog "journal backend, then reinstall sys-apps/systemd with USE=python"
		fi
	fi
}
