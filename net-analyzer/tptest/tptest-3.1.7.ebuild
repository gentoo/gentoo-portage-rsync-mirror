# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tptest/tptest-3.1.7.ebuild,v 1.3 2008/11/08 15:29:23 cedk Exp $

inherit toolchain-funcs

DESCRIPTION="Internet bandwidth tester"
HOMEPAGE="http://tptest.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}

	cd "${S}"/apps/unix/server
	sed -i \
		-e "s:^CFLAGS		=:CFLAGS+=:" \
		-e "s:CC		=:CC?=:" \
		Makefile

	cd "${S}"/apps/unix/client
	sed -i \
		-e "s:^CFLAGS		=:CFLAGS+=:" \
		-e "s:CC		=:CC+=:" \
		Makefile

	cp -f "${S}"/os-dep/unix/* .
	cp -f "${S}"/engine/* .
}

src_compile() {
	cd "${S}"/apps/unix/server
	emake CC=$(tc-getCC) || die "emake failed"

	cd "${S}"/apps/unix/client
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	dobin "${S}"/apps/unix/client/tptestclient
	dosbin "${S}"/apps/unix/server/tptestserver

	insinto /etc
	doins "${S}"/apps/unix/server/tptest.conf
}
