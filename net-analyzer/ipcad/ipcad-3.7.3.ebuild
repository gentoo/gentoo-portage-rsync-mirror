# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipcad/ipcad-3.7.3.ebuild,v 1.6 2012/12/05 16:23:23 jer Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="IP Cisco Accounting Daemon"
HOMEPAGE="http://ipcad.sourceforge.net/"
SRC_URI="mirror://sourceforge/ipcad/${P}.tar.gz"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="net-libs/libpcap
	net-firewall/iptables"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.7-linux-2.6.27.patch \
		"${FILESDIR}"/${PN}-3.7-linux-2.6.35.patch \
		"${FILESDIR}"/${P}-signal_h.patch

	eautoreconf
}

src_install() {
	sed -i -e "s/^chroot = \/adm\/tmp;/chroot = \/var\/ipcad;/" ipcad.conf.default
	sed -i -e "s/^interface/#interface/" ipcad.conf.default
	sed -i -e "s/^aggregate/#aggregate/" ipcad.conf.default
	sed -i -e "s/^pidfile = ipcad.pid;/pidfile = \/run\/ipcad.pid;/" ipcad.conf.default

	dodoc AUTHORS ChangeLog README BUGS FAQ ipcad.conf.simple ipcad.conf.default

	dosbin ipcad || die

	insinto /etc
	insopts -m0600
	newins ipcad.conf.default ipcad.conf

	keepdir /var/ipcad/run

	doman ipcad.8 ipcad.conf.5

	newinitd "${FILESDIR}"/ipcad.init ipcad
	newconfd "${FILESDIR}"/ipcad.conf.d ipcad
}
