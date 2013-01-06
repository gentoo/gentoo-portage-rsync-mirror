# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/rtpbreak/rtpbreak-1.3a.ebuild,v 1.3 2011/04/05 17:04:16 signals Exp $

EAPI=1

inherit eutils toolchain-funcs

DESCRIPTION="Detects, reconstructs and analyzes any RTP session through heuristics over the UDP network traffic"
HOMEPAGE="http://xenion.reactive-search.com/?page_id=7"
SRC_URI="http://xenion.antifork.org/rtpbreak/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libnet:1.1
	>=net-libs/libpcap-0.7"

RDEPEND=$DEPEND

src_unpack() {
	unpack ${A}
	# Use limits.h PATH_MAX
	epatch "${FILESDIR}"/${P}-limits.patch \
		"${FILESDIR}"/${P}-missing-headers.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin src/rtpbreak || die "cannot install rtpbreak"
	dodoc CHANGELOG THANKS || die "Failed to install documentation"
	dohtml doc/* || die "Failed to install documentation"
}
