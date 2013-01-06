# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/minissdpd/minissdpd-1.2-r1.ebuild,v 1.1 2012/12/25 21:03:11 blueness Exp $

EAPI="4"
inherit eutils toolchain-funcs

DESCRIPTION="MiniSSDP Daemon"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"
HOMEPAGE="http://miniupnp.free.fr/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/net-tools-1.60_p20120127084908[old-output]
	|| ( net-misc/miniupnpd net-libs/miniupnpc )"

src_prepare() {
	epatch "${FILESDIR}/${P}-respect-CC.patch"
	epatch "${FILESDIR}/${P}-remove-initd.patch"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install () {
	einstall PREFIX="${D}"
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dodoc Changelog.txt README
	doman minissdpd.1
}
