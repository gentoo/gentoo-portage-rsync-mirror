# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/denyhosts/denyhosts-2.6-r6.ebuild,v 1.7 2012/12/01 19:41:24 armin76 Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_DEPEND="2"

inherit distutils eutils

MY_PN="DenyHosts"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="DenyHosts is a utility to help sys admins thwart ssh hackers"
HOMEPAGE="http://www.denyhosts.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="${MY_PN}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# changes default file installations
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-log-injection-regex.patch

	# Multiple patches from Fedora and Debian
	epatch "${FILESDIR}"/${P}-daemon-control.patch
	epatch "${FILESDIR}"/${P}-defconffile.patch
	epatch "${FILESDIR}"/${P}-foreground_mode.patch
	epatch "${FILESDIR}"/${P}-hostname.patch
	epatch "${FILESDIR}"/${P}-plugin_deny.patch
	epatch "${FILESDIR}"/${P}-single_config_switch.patch

	sed -i -e 's:DENY_THRESHOLD_VALID = 10:DENY_THRESHOLD_VALID = 5:' \
		denyhosts.cfg-dist || die "sed failed"
}

src_install() {
	DOCS="CHANGELOG.txt README.txt PKG-INFO"
	distutils_src_install

	insinto /etc
	insopts -m0640
	newins denyhosts.cfg-dist denyhosts.conf

	dodir /etc/logrotate.d
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}

	newinitd "${FILESDIR}"/denyhosts.init denyhosts

	# build system installs docs that we installed above
	rm -f "${D}"/usr/share/denyhosts/*.txt

	keepdir /var/lib/denyhosts
}

pkg_postinst() {
	distutils_pkg_postinst

	if [[ ! -f "${ROOT}etc/hosts.deny" ]]; then
		touch "${ROOT}etc/hosts.deny"
	fi

	if [ "$(rc-config list default | grep denyhosts)" = "" ] ; then
	elog "You can configure DenyHosts to run as a daemon by running:"
	elog
	elog "rc-update add denyhosts default"
	elog
	fi

	elog "To run DenyHosts as a cronjob instead of a daemon add the following"
	elog "to /etc/crontab"
	elog "# run DenyHosts every 10 minutes"
	elog "*/10  *  * * *	root	/usr/bin/denyhosts.py -c /etc/denyhosts.conf"
	elog
	elog "More information can be found at http://denyhosts.sourceforge.net/faq.html"
	elog
	ewarn "Modify /etc/denyhosts.conf to suit your environment system."
}
