# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/dc-tool-ip/dc-tool-ip-1.0.4.ebuild,v 1.4 2010/09/17 07:02:34 vapier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="ethernet program loader for the Dreamcast"
HOMEPAGE="http://cadcdev.sourceforge.net/"
SRC_URI="mirror://sourceforge/cadcdev/dcload-ip-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

S=${WORKDIR}/dcload-ip-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-bfd-update.patch
	epatch "${FILESDIR}"/${P}-headers.patch
	sed -i \
		-e "/^HOSTCC/s:gcc:$(tc-getCC):" \
		-e "/^HOSTCFLAGS/s:-O2:${CFLAGS} ${CPPFLAGS}:" \
		-e 's:-L/usr/local/dcdev/lib:$(LDFLAGS):' \
		-e 's:/usr/local/dcdev/include:.:' \
		Makefile.cfg || die "sed"
}

src_compile() {
	emake -C host-src/tool || die
}

src_install() {
	dobin host-src/tool/dc-tool || die "tool"
	dodoc README NETWORK CHANGES

	docinto make-cd
	dodoc make-cd/*

	if use doc ; then
		docinto example-src
		dodoc example-src/*
	fi
}
