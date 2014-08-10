# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/kpnadsl4linux/kpnadsl4linux-1.10-r1.ebuild,v 1.17 2014/08/10 20:55:54 slyfox Exp $

DESCRIPTION="ADSL4Linux, a PPTP start/stop/etc. program especially for Dutch users, for gentoo"
HOMEPAGE="http://www.adsl4linux.nl/"
SRC_URI="http://home.planet.nl/~mcdon001/${P}.tar.gz
	http://www.adsl4linux.nl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64 ppc64"
IUSE=""

RDEPEND=">=net-dialup/pptpclient-1.7.0
	>=net-dialup/ppp-2.4.2"

src_compile() {
	make || die "Make failed."
}

src_install() {
	dosbin adsl
	dodoc Changelog README
	newinitd init.d.adsl adsl
	dosbin "${FILESDIR}/${PN}-config"
}

pkg_postinst() {
	einfo "Do _NOT_ forget to run the following if this is your _FIRST_ install:"
	einfo "   kpnadsl4linux-config"
	einfo "   etc-update"
	einfo
	einfo "To start ${P} at boot type:"
	einfo "   rc-update add adsl default"
}
