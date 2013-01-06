# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/bastille/bastille-3.0.9.ebuild,v 1.1 2009/01/09 00:36:14 battousai Exp $

inherit eutils

PATCHVER=0.2
MY_PN=${PN/b/B}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_PN}
DESCRIPTION="Bastille-Linux is a security hardening tool"
HOMEPAGE="http://bastille-linux.org/"
SRC_URI="mirror://sourceforge/${PN}-linux/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="X"

RDEPEND="net-firewall/iptables
	app-admin/logrotate
	dev-perl/Curses
	net-firewall/psad
	X? ( dev-perl/perl-tk )
	virtual/logger"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/${P}-gentoo-${PATCHVER}.patch

	cd "${S}"
	chmod a+x Install.sh bastille-ipchains bastille-netfilter
}

src_install() {

	cd "${S}"
	DESTDIR="${D}" ./Install.sh

	# Example configs
	cd "${S}"
	insinto /usr/share/Bastille
	doins *.config

	newinitd ${PN}-firewall.gentoo-init ${PN}-firewall

	# Documentation
	cd "${S}"
	dodoc *.txt BUGS Change* README*
	cd "${S}"/docs
	doman *.1m
}

pkg_postinst() {
	elog "Please be aware that when using the Server Lax, Server Moderate, or"
	elog "Server Paranoia configurations, you may need to use InteractiveBastille"
	elog "to set any advanced network information, such as masquerading and"
	elog "internal interfaces, if you plan to use them."
}
