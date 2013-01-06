# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpxy/udpxy-1.0.21.2-r1.ebuild,v 1.2 2012/03/22 11:14:46 pva Exp $

EAPI="4"

inherit toolchain-funcs eutils versionator

MY_PV=$(replace_version_separator 3 -)
DESCRIPTION="small-footprint daemon to relay multicast UDP traffic to client's TCP (HTTP) connection"
HOMEPAGE="http://sourceforge.net/projects/udpxy/"
SRC_URI="mirror://sourceforge/${PN}/${PN}.${MY_PV}-prod.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}/${P}-LDFLAGS.patch"
}

src_configure() {
	tc-export CC
}

src_install() {
	dobin udpxy
	dosym udpxy /usr/bin/udpxrec

	dodoc README CHANGES
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}
