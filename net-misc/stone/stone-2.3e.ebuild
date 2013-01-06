# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.3e.ebuild,v 1.4 2009/03/14 19:13:49 nixnut Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${PN}-2.3d-2.3.2.7"

src_compile() {
	local myargs

	if use ssl ; then
		myargs="${myconf} SSL=/usr linux-ssl"
	else
		myargs="${myconf} linux"
	fi

	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -D_GNU_SOURCE" \
		${myargs} || die
}

src_install() {
	dobin stone
	# doman stone.1
	dodoc README*
}
