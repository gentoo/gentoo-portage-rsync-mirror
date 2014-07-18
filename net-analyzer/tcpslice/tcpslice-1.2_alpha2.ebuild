# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpslice/tcpslice-1.2_alpha2.ebuild,v 1.8 2014/07/17 16:52:46 jer Exp $

inherit eutils versionator

MY_P="${PN}_$(get_version_component_range 1-2)a2"

DESCRIPTION="Extract and concatenate portions of pcap files"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="mirror://gentoo/${MY_P}.orig.tar.gz
	mirror://gentoo/${MY_P}-4.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="net-libs/libpcap"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P/_/-}"

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}/${MY_P}-4.diff.gz"
	cd "${S}"
	sed -i -e 's:net/bpf.h:pcap-bpf.h:g' tcpslice.{h,c} || die
}

src_install() {
	dosbin tcpslice
	doman tcpslice.1
	dodoc README
}
