# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iperf/iperf-2.0.5-r1.ebuild,v 1.2 2012/10/06 13:43:23 pinkbyte Exp $

EAPI="4"

inherit base

DESCRIPTION="Tool to measure IP bandwidth using UDP or TCP"
HOMEPAGE="http://iperf.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~m68k-mint"
IUSE="ipv6 threads debug"

DEPEND=""
RDEPEND=""

PATCHES=( "${FILESDIR}"/"${PN}"-fix-bandwidth-limit.patch )
DOCS="INSTALL README"

src_configure() {
	econf \
		$(use_enable ipv6) \
		$(use_enable threads) \
		$(use_enable debug debuginfo)
}

src_install() {
	default
	dohtml doc/*
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}

pkg_postinst() {
	echo
	einfo "To run iperf in server mode, run:"
	einfo "  /etc/init.d/iperf start"
	echo
}
