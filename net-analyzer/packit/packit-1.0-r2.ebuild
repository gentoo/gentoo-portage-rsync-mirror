# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/packit/packit-1.0-r2.ebuild,v 1.3 2012/06/13 08:53:37 jdhore Exp $

EAPI=4
inherit eutils

DESCRIPTION="network auditing tool that allows you to monitor, manipulate, and inject customized IPv4 traffic"
HOMEPAGE="http://packetfactory.openwall.net/projects/packit/"
SRC_URI="${HOMEPAGE}downloads/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=">=net-libs/libnet-1.1.2
	net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i 's:net/bpf.h:pcap-bpf.h:g' "${S}"/src/{globals.h,main.h} || die
	epatch \
		"${FILESDIR}"/packit-1.0-noopt.patch \
		"${FILESDIR}"/packit-1.0-nostrip.patch \
		"${FILESDIR}"/packit-1.0-overflow.patch \
		"${FILESDIR}"/packit-1.0-format.patch
}

src_install() {
	default
	dodoc docs/*
}
