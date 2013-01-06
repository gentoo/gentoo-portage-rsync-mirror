# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qenv/qenv-0.1.ebuild,v 1.3 2010/12/02 01:12:00 flameeyes Exp $

inherit autotools eutils

DESCRIPTION="Pool of machines handler for QEMU"
HOMEPAGE="http://virutass.net/software/qemu/"
SRC_URI="http://virutass.net/software/qemu/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# these should in RDEPEND only, but configure fails without them
RDEPEND=">=app-emulation/qemu-0.7.2
		net-firewall/iptables
		net-misc/bridge-utils
		app-admin/sudo
		net-dns/dnsmasq"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.1-qemu-0.7.2.patch
	eautoreconf
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README AUTHORS || die
}
