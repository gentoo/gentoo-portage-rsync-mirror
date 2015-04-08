# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslh/sslh-1.16.ebuild,v 1.1 2014/02/14 17:54:46 kensington Exp $

EAPI=5

MY_P="${PN}-v${PV}"
inherit toolchain-funcs

DESCRIPTION="Port multiplexer - accept both HTTPS and SSH connections on the same port"
HOMEPAGE="http://www.rutschle.net/tech/sslh.shtml"
SRC_URI="http://www.rutschle.net/tech/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="caps tcpd"

RDEPEND="caps? ( sys-libs/libcap )
	tcpd? ( sys-apps/tcp-wrappers )
	dev-libs/libconfig"
DEPEND="${RDEPEND}
	dev-lang/perl"

RESTRICT="test"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		USELIBCAP=$(usev caps) \
		USELIBWRAP=$(usev tcpd)
}

src_install() {
	dosbin sslh-{fork,select}
	dosym sslh-fork /usr/sbin/sslh
	doman sslh.8.gz
	dodoc ChangeLog README.md

	newinitd "${FILESDIR}"/sslh.init.d-2 sslh
	newconfd "${FILESDIR}"/sslh.conf.d-2 sslh
}
