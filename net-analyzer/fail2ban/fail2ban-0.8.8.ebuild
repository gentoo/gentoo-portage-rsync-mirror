# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.8.8.ebuild,v 1.7 2013/01/04 13:15:29 ago Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit distutils eutils vcs-snapshot

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://www.fail2ban.org/"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="selinux"

DEPEND="selinux? ( sec-policy/selinux-fail2ban )"
RDEPEND="net-misc/whois
	virtual/mta
	virtual/logger
	net-firewall/iptables
	selinux? ( sec-policy/selinux-fail2ban )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e 's|/var\(/run/fail2ban\)|\1|g' $( find . -type f ) || die
}

src_install() {
	distutils_src_install

	newconfd files/gentoo-confd fail2ban
	newinitd files/gentoo-initd fail2ban
	dodoc ChangeLog README TODO
	doman man/*.1

	# Use INSTALL_MASK  if you do not want to touch /etc/logrotate.d.
	# See http://thread.gmane.org/gmane.linux.gentoo.devel/35675
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}-logrotate ${PN}
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.7"
	previous_less_than_0_7=$?
}

pkg_postinst() {
	distutils_pkg_postinst

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
}
