# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/fdm/fdm-1.5-r1.ebuild,v 1.1 2010/09/12 19:12:24 xmw Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="fetch, filter and deliver mail"
HOMEPAGE="http://fdm.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples pcre"

DEPEND="dev-libs/openssl
	sys-libs/tdb
	pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser _fdm
}

src_prepare() {
	rm Makefile || die
	epatch "${FILESDIR}"/${PF}-GNUmakefile.patch
}

src_compile() {
	emake CC="$(tc-getCC)" \
		PCRE=$(use pcre && echo 1) || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die
	dodoc CHANGES MANUAL README TODO || die
	if use examples ; then
		docinto examples
		dodoc examples/* || die
	fi
}
