# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/softflowd/softflowd-0.9.9.ebuild,v 1.2 2012/11/21 04:36:12 jer Exp $

EAPI=4

inherit eutils

DESCRIPTION="A flow-based network monitor."
HOMEPAGE="http://www.mindrot.org/softflowd.html"
SRC_URI="http://softflowd.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-strip.patch
}

src_install() {
	default

	docinto examples
	dodoc collector.pl

	newinitd "${FILESDIR}"/${PN}.initd ${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
}
