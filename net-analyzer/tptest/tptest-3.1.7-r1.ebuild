# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tptest/tptest-3.1.7-r1.ebuild,v 1.1 2010/09/20 18:32:35 jer Exp $

EAPI="2"

inherit toolchain-funcs

MY_PV="${PV/./_}"

DESCRIPTION="Internet bandwidth tester"
HOMEPAGE="http://tptest.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	sed -i apps/unix/{client,server}/Makefile \
		-e "s:^CFLAGS[[:space:]]*=:CFLAGS+=:" \
		|| die "sed Makefiles"

	cp -f os-dep/unix/* .
	cp -f engine/* .
}

src_compile() {
	emake -C apps/unix/client \
		CC=$(tc-getCC) \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake client"
	emake -C apps/unix/server \
		CC=$(tc-getCC) \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake server"
}

src_install() {
	dobin apps/unix/client/tptestclient
	dosbin apps/unix/server/tptestserver

	insinto /etc
	doins apps/unix/server/tptest.conf
}
