# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/usermin/usermin-1.430.ebuild,v 1.2 2012/07/12 15:14:55 axs Exp $

IUSE="ssl"

inherit eutils pam

DESCRIPTION="a web-based user administration interface"
HOMEPAGE="http://www.webmin.com/index6.html"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="dev-lang/perl"

RDEPEND="${DEPEND}
	sys-process/lsof
	ssl? ( dev-perl/Net-SSLeay )"

#	 pam? ( dev-perl/Authen-PAM )

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Point to the correct mysql location
	sed -i -e "s:/usr/local/mysql:/usr:g" mysql/config

	epatch "${FILESDIR}"/${PN}-1.080-safestop.patch
	epatch "${FILESDIR}"/${PN}-1.150-setup-nocheck.patch
}

src_install() {
	# Change /usr/local/bin/perl references
	find . -type f | xargs sed -i -e 's:^#!.*/usr/local/bin/perl:#!/usr/bin/perl:'

	dodir /usr/libexec/usermin
	cp -pR * "${D}"/usr/libexec/usermin

	newinitd "${FILESDIR}"/init.d.usermin usermin

	newpamd "${FILESDIR}"/${PN}.pam-include.1 ${PN}

	# Fix ownership
	chown -R root:0 "${D}"

	dodir /etc/usermin
	dodir /var/log/usermin

	config_dir=${D}/etc/usermin
	var_dir=${D}/var/log/usermin
	perl=/usr/bin/perl
	autoos=1
	port=20000
	login=root
	crypt="XXX"
	host=`hostname`
	use ssl && ssl=1 || ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	tempdir="${T}"
	export config_dir var_dir perl autoos port login crypt host ssl atboot nostart nochown autothird nouninstall noperlpath tempdir
	"${D}"/usr/libexec/usermin/setup.sh > "${T}"/usermin-setup.out 2>&1 || die "Failed to create initial usermin configuration."

	# Fixup the config files to use their real locations
	sed -i -e "s:^pidfile=.*$:pidfile=/var/run/usermin.pid:" "${D}"/etc/usermin/miniserv.conf
	find "${D}"/etc/usermin -type f | xargs sed -i -e "s:${D}:/:g"

	# Cleanup from the config script
	rm -rf "${D}"/var/log/usermin
	keepdir /var/log/usermin/
}

pkg_postinst() {
	elog "To make usermin start at boot time, run: 'rc-update add usermin default'."
	elog "Point your web browser to https://localhost:20000 to use usermin."
}
