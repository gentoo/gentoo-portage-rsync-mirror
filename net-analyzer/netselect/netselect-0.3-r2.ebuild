# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netselect/netselect-0.3-r2.ebuild,v 1.11 2012/10/14 21:53:59 aballier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Ultrafast implementation of ping."
HOMEPAGE="http://alumnit.ca/~apenwarr/netselect/index.html"
SRC_URI="http://alumnit.ca/~apenwarr/netselect/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-bsd.patch"
}

src_compile() {
	sed -i \
		-e "s:PREFIX =.*:PREFIX = ${D}usr:" \
		-e "s:CFLAGS =.*:CFLAGS = -Wall -I. -g ${CFLAGS}:" \
		-e "s:LDFLAGS =.*:LDFLAGS = -g ${LDFLAGS}:" \
		-e '23,27d' \
		-e '34d' \
		Makefile \
		|| die "sed Makefile failed"

	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install () {
	dobin netselect || die "dobin failed"
	fowners root:wheel /usr/bin/netselect
	fperms 4711 /usr/bin/netselect
	dodoc ChangeLog HISTORY README*
}
