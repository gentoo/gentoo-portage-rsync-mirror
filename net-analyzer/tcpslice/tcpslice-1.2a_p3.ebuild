# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpslice/tcpslice-1.2a_p3.ebuild,v 1.1 2010/06/24 05:33:29 jer Exp $

EAPI="2"

inherit eutils

MY_P="${PN}_${PV/_p/}"

DESCRIPTION="a program for extracting portions of packet-trace files generated using tcpdump's -w flag, and to glue together pcap dump files"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="mirror://debian/pool/main/t/tcpslice/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/t/tcpslice/${MY_P}-4.debian.tar.gz"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-libs/libpcap"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P/_/-}"

src_prepare() {
	epatch "${WORKDIR}/debian/patches/"
	sed -i -e 's:net/bpf.h:pcap-bpf.h:g' tcpslice.{h,c} || die
}

src_install() {
	dosbin tcpslice || die "dosbin failed"
	doman tcpslice.1
	dodoc README
}
